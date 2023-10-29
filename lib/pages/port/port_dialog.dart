import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/model/port_list/datum.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PortDialog extends StatefulWidget {
  PortDialog({
    super.key,
    required this.tag,
    required this.title,
    this.data,
    this.operationType = 0,
  });
  String tag;
  String title;
  Datum? data;
  int operationType; // 0 添加 1 编辑

  @override
  State<PortDialog> createState() => _PortDialogState();
}

class _PortDialogState extends State<PortDialog> {
  final TextEditingController _port = TextEditingController();
  final TextEditingController _mark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.data != null) {
      _port.text = widget.data!.port.toString();
      _mark.text = widget.data!.mark!;
    }

    var portStore = Provider.of<PortStore>(context);

    return Container(
      height: 270,
      width: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                Text(widget.title, style: AppTheme.sizeTextStyle(16)),
                const Spacer(),
                BarButton(
                    icon: Resources.cancel,
                    onTap: () async {
                      await SmartDialog.dismiss(tag: widget.tag, result: false);
                    }),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const CustomDivider(),
          const SizedBox(height: 30),
          Form(
            key: _formKey,
            child: Column(
              children: [
                _item('端口号', _port, '请填写端口号', true),
                _item('备　注', _mark, '请填写备注', true),
              ],
            ),
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              PlainButton(
                name: '关闭',
                onPressed: () async {
                  await SmartDialog.dismiss(tag: widget.tag, result: false);
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '确定',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (widget.operationType == 0) {
                      Datum portData = Datum();
                      portData.port = int.parse(_port.text);
                      portData.mark = _mark.text;
                      // portStore.data = portData;

                      portStore.createData = portData;
                      await portStore.createPort();
                      await SmartDialog.dismiss(tag: widget.tag, result: true);
                    }
                  }
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  _item(
      String name, TextEditingController control, String hint, bool isHaveTo) {
    return Row(
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: CustomFormTextField(
            controller: control,
            title: name,
            titleWidth: 65,
            hintText: hint,
            isHaveTo: isHaveTo,
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}

Future<bool> addPort() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_repo',
    builder: (context) {
      return PortDialog(tag: 'add_repo', title: '添加端口号');
    },
  );

  return result;
}

Future<bool> editPort(Datum data) async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_repo',
    builder: (context) {
      return PortDialog(tag: 'edit_repo', title: '修改端口号信息', data: data);
    },
  );

  return result;
}
