import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_grape_ui/api/node.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/custom_group_radio.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/pages/port/node/upload.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/target_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_select.dart';

// ignore: must_be_immutable
class NodeDialog extends StatefulWidget {
  NodeDialog({
    super.key,
    required this.title,
  });
  String title;

  @override
  State<NodeDialog> createState() => _NodeDialogState();
}

class _NodeDialogState extends State<NodeDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _target = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  final TextEditingController _pagePath = TextEditingController();
  String _fileName = '';
  int nodeType = 0;

  final _formKey = GlobalKey<FormState>();

  late TargetStore target;

  Future<void> _getData() async {
    await target.list();
  }

  @override
  void initState() {
    super.initState();
    target = Provider.of<TargetStore>(context, listen: false);

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    var node = Provider.of<NodeStore>(context);
    var port = Provider.of<PortStore>(context);

    if (node.operationType == 1) {
      _name.text = node.modifyData.name.toString();
      _target.text = node.modifyData.target.toString();
      _mark.text = node.modifyData.mark.toString();
      nodeType = node.modifyData.nodeType!;
      var path = node.modifyData.pagePath.toString();
      _pagePath.text = path;
      debugPrint('build -----123');
    }

    return Scaffold(
      body: Container(
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
                      onTap: () {
                        GoRouter.of(context).pop();
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
                  formFieldItem('节点名称', _name, '请填写节点名称', isHaveTo: true),
                  _itemGroupRadio(),
                  Consumer<TargetStore>(
                    builder: (context, value, child) {
                      List<SelectOption> list = [];
                      if (value.data != null) {
                        for (var element in value.data!.data!) {
                          list.add(
                            SelectOption(element.id!, element.name!),
                          );
                        }
                      }
                      child = formSelectFieldItem(list, '目标地址', _target, '目标地址',
                          onChanged: (key, value) {
                        _target.text = value.toString();
                      });

                      return child!;
                    },
                  ),
                  formFieldItem('备注', _mark, '请填写备注', line: 3),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // 页面上传
            _itemStaticPage(node.operationType, node),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                PlainButton(
                  name: '关闭',
                  onPressed: () {
                    GoRouter.of(context).pop();
                  },
                ),
                const SizedBox(width: 10),
                CustomButton(
                  name: '确定',
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (node.operationType == 0) {
                        node.createData.portId = port.selectData.id;
                        node.createData.name = _name.text;
                        node.createData.nodeType = nodeType;
                        node.createData.target = _target.text;
                        node.createData.mark = _mark.text;
                        await node.create();
                      }

                      if (node.operationType == 1) {
                        node.modifyData.name = _name.text;
                        node.modifyData.nodeType = nodeType;
                        node.modifyData.target = _target.text;
                        node.modifyData.mark = _mark.text;
                        node.modifyData.pagePath = _pagePath.text;
                        await node.modify();
                      }

                      await node.list();
                      // ignore: use_build_context_synchronously
                      GoRouter.of(context).pop();
                    }
                  },
                ),
                const SizedBox(width: 10),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _itemGroupRadio() {
    return Row(
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: CustomGroupRadio(
            items: const ['接口', '页面'],
            title: '节点类型',
            titleWidth: 55,
            isHaveTo: true,
            group: nodeType,
            onChanged: (val) {
              nodeType = val!;
            },
          ),
        ),
      ],
    );
  }

  _itemStaticPage(int t, NodeStore node) {
    if (t == 0) {
      return Container();
    }

    return Row(
      children: [
        const SizedBox(width: 30),
        SizedBox(
          width: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: const [Text('页面', style: AppTheme.defaultTextStyle)],
          ),
        ),
        const SizedBox(width: 15),
        // 上传
        UploadFile(
          controller: _pagePath,
          portId: node.portId,
          nodeId: node.modifyData.id!,
        ),
      ],
    );
  }
}
