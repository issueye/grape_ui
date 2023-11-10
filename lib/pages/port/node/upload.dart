import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_toast.dart';

import '../../../api/node.dart';
import '../../../components/bar_button.dart';
import '../../../components/custom_button.dart';
import '../../../utils/app_theme.dart';

// ignore: must_be_immutable
class UploadFile extends StatefulWidget {
  UploadFile(
      {super.key,
      required this.controller,
      required this.nodeId,
      required this.portId});
  final TextEditingController controller;
  String nodeId;
  String portId;

  @override
  State<UploadFile> createState() => _UploadFileState();
}

class _UploadFileState extends State<UploadFile> {
  String _fileName = '';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Row(
          children: [
            CustomButton(
              name: '选择',
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  lockParentWindow: true,
                );
                if (result != null) {
                  PlatformFile file = result.files.single;
                  debugPrint('file = $file');
                  _fileName = file.name;
                  debugPrint('_fileName = $_fileName');
                  debugPrint('path = ${file.path.toString()}');
                  setState(() {
                    widget.controller.text = file.path.toString();
                  });
                }
              },
            ),
            const SizedBox(width: 10),
            CustomButton(
              name: '上传',
              onPressed: () async {
                if (_fileName == '') return;
                var res = await NodeApi.upload(
                  widget.controller.text,
                  _fileName,
                  options: {
                    'node_id': widget.nodeId,
                    'port_id': widget.portId,
                  },
                );

                if (res.code != 200) {
                  Toast.Error(res.message.toString());
                } else {
                  Toast.Success(res.message.toString());
                }
              },
            ),
            const SizedBox(width: 30),
          ],
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Tooltip(
                  preferBelow: false,
                  verticalOffset: 8,
                  message: widget.controller.text,
                  child: Text(
                    widget.controller.text,
                    overflow: TextOverflow.ellipsis,
                    style:
                        AppTheme.sizeTextStyle(11, color: AppTheme.dangerColor),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              widget.controller.text != ''
                  ? BarButton(
                      icon: Resources.cancel2(
                          color: AppTheme.dangerColor, size: 11),
                      onTap: () {
                        setState(() {
                          widget.controller.clear();
                        });
                      },
                    )
                  : Container(),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
