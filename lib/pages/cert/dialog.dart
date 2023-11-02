import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/store/cert_store.dart';
import 'package:go_grape_ui/store/target_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../model/target/datum.dart';

// ignore: must_be_immutable
class CertDialog extends StatefulWidget {
  CertDialog({
    super.key,
    required this.tag,
    required this.title,
    this.data,
  });
  String tag;
  String title;
  Datum? data;

  @override
  State<CertDialog> createState() => _CertDialogState();
}

class _CertDialogState extends State<CertDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _public = TextEditingController();
  final TextEditingController _private = TextEditingController();
  final TextEditingController _mark = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var cert = Provider.of<CertStore>(context);

    if (cert.operationType == 1) {
      _name.text = cert.modifyData.name!;
      _public.text = cert.modifyData.public!;
      _private.text = cert.modifyData.private!;
      _mark.text = cert.modifyData.mark!;
    }

    return Container(
      height: 450,
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
                formFieldItem('证书名称', _name, '请填写证书名称', isHaveTo: true),
                formFieldItem('公钥路径', _public, '请公钥证书路径'),
                formFieldItem('私钥路径', _private, '请私钥证书路径'),
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
                    if (cert.operationType == 0) {
                      cert.createData.name = _name.text;
                      cert.createData.public = _public.text;
                      cert.createData.private = _private.text;
                      cert.createData.mark = _mark.text;
                      
                      await cert.create();
                      await SmartDialog.dismiss(tag: widget.tag, result: true);
                    }

                    if (cert.operationType == 1) {
                      cert.modifyData.name = _name.text;
                      cert.modifyData.public = _public.text;
                      cert.modifyData.private = _private.text;
                      cert.modifyData.mark = _mark.text;
                      await cert.modify();
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

Future<bool> addCert() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_cert',
    builder: (context) {
      return CertDialog(tag: 'add_cert', title: '添加证书');
    },
  );

  return result;
}

Future<bool> editCert() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_cert',
    builder: (context) {
      return CertDialog(tag: 'edit_cert', title: '修改证书信息');
    },
  );

  return result;
}
