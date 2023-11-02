import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/store/target_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../model/target/datum.dart';

// ignore: must_be_immutable
class TargetDialog extends StatefulWidget {
  TargetDialog({
    super.key,
    required this.tag,
    required this.title,
    this.data,
  });
  String tag;
  String title;
  Datum? data;

  @override
  State<TargetDialog> createState() => _TargetDialogState();
}

class _TargetDialogState extends State<TargetDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var target = Provider.of<TargetStore>(context);

    if (target.operationType == 1) {
      _name.text = target.modifyData.name!;
      _mark.text = target.modifyData.mark!;
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                formFieldItem('地址', _name, '请填写目标地址', isHaveTo: true),
                formFieldItem('备注', _mark, '请填写备注', line: 3),
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
                    if (target.operationType == 0) {
                      target.createData.name = _name.text;
                      target.createData.mark = _mark.text;
                      await target.create();
                      await SmartDialog.dismiss(tag: widget.tag, result: true);
                    }

                    if (target.operationType == 1) {
                      target.modifyData.name = _name.text;
                      target.modifyData.mark = _mark.text;
                      await target.modify();
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
}

Future<bool> addTarget() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_target',
    builder: (context) {
      return TargetDialog(tag: 'add_target', title: '添加目标地址');
    },
  );

  return result;
}

Future<bool> editTarget() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_target',
    builder: (context) {
      return TargetDialog(tag: 'edit_target', title: '修改目标地址');
    },
  );

  return result;
}
