import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/custom_group_radio.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/model/port/datum.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NodeDialog extends StatefulWidget {
  NodeDialog({
    super.key,
    required this.tag,
    required this.title,
    this.data,
  });
  String tag;
  String title;
  Datum? data;

  @override
  State<NodeDialog> createState() => _NodeDialogState();
}

class _NodeDialogState extends State<NodeDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _target = TextEditingController();
  final TextEditingController _mark = TextEditingController();
  int nodeType = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var node = Provider.of<NodeStore>(context);

    if (widget.data != null) {
      _name.text = widget.data!.port.toString();
      _mark.text = widget.data!.mark!;
    }

    return Container(
      height: 420,
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
                _item('节点名称', _name, '请填写节点名称', true),
                _itemGroupRadio(),
                _item('目标地址', _target, '请填写目标地址', true),
                _item('备　注', _mark, '请填写备注', true, line: 3),
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
                    if (node.operationType == 0) {
                      node.createData.name = _name.text;
                      node.createData.nodeType = nodeType;
                      node.createData.target = _target.text;
                      node.createData.mark = _mark.text;
                      await node.create();
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

  _itemGroupRadio() {
    return Row(
      children: [
        const SizedBox(width: 30),
        Expanded(
          child: CustomGroupRadio(
            items: const ['接口', '页面'],
            title: '节点类型',
            titleWidth: 65,
            selectItem: nodeType,
            isHaveTo: true,
          ),
        ),
      ],
    );
  }

  _item(
      String name, TextEditingController control, String hint, bool isHaveTo, {int line = 1}) {
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
            lines: line,
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}

Future<bool> addNode() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_node',
    builder: (context) {
      return NodeDialog(tag: 'add_node', title: '添加节点信息');
    },
  );

  return result;
}

Future<bool> editNode() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_node',
    builder: (context) {
      var node = Provider.of<NodeStore>(context);
      node.operationType = 1;
      return NodeDialog(tag: 'edit_node', title: '修改节点信息');
    },
  );

  return result;
}
