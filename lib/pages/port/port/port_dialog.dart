import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class PortDialog extends StatefulWidget {
  PortDialog({
    super.key,
    required this.tag,
    required this.title,
  });
  String tag;
  String title;

  @override
  State<PortDialog> createState() => _PortDialogState();
}

class _PortDialogState extends State<PortDialog> {
  final TextEditingController _port = TextEditingController();
  final TextEditingController _mark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var port = Provider.of<PortStore>(context);

    // 清空值
    if (port.operationType == 0) {
      _port.text = '';
      _mark.text = '';
    }

    // 如果是编辑则赋值给表单
    if (port.operationType == 1) {
      _port.text = port.modifyData.port.toString();
      _mark.text = port.modifyData.mark!;
    }

    return Container(
      height: 300,
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
          // 表单
          Form(
            key: _formKey,
            child: Column(
              children: [
                formFieldItem('端口号', _port, '请填写端口号', isHaveTo: true),
                formFieldItem('备　注', _mark, '请填写备注', line: 3),
              ],
            ),
          ),
          const Spacer(),
          // 按钮
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
                    // 添加新增
                    if (port.operationType == 0) {
                      port.createData.port = int.parse(_port.text);
                      port.createData.mark = _mark.text;
                      await port.create();
                    }

                    // 编辑
                    if (port.operationType == 1) {
                      port.modifyData.port = int.parse(_port.text);
                      port.modifyData.mark = _mark.text;
                      await port.modify();
                    }

                    await SmartDialog.dismiss(tag: widget.tag, result: true);
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

  // 项目
  _item(
      String name, TextEditingController control, String hint, bool isHaveTo, {int lines = 1}) {
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
            lines: lines,
          ),
        ),
        const SizedBox(width: 30),
      ],
    );
  }
}

// 添加端口信息弹窗
Future<bool> addPort() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_port',
    builder: (context) {
      return PortDialog(tag: 'add_port', title: '添加端口号');
    },
  );

  return result;
}

// 编辑端口信息弹窗
Future<bool> editPort() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_port',
    builder: (context) {
      return PortDialog(tag: 'edit_port', title: '修改端口号');
    },
  );

  return result;
}
