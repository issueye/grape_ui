import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/custom_select.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/rule_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class RuleDialog extends StatefulWidget {
  RuleDialog({
    super.key,
    required this.tag,
    required this.title,
    required this.list,
  });
  String tag;
  String title;
  List<SelectOption> list;

  @override
  State<RuleDialog> createState() => _RuleDialogState();
}

class _RuleDialogState extends State<RuleDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _port = TextEditingController();
  final TextEditingController _node = TextEditingController();
  final TextEditingController _matchType = TextEditingController();
  final TextEditingController _targetId = TextEditingController();
  final TextEditingController _targetRoute = TextEditingController();
  final TextEditingController _mark = TextEditingController();

  // late RuleStore rule;
  // late PortStore port;
  // late NodeStore node;
  // late TargetStore target;

  @override
  void initState() {
    super.initState();
    // rule = Provider.of<RuleStore>(widget.ctx);
    // port = Provider.of<PortStore>(widget.ctx);
    // node = Provider.of<NodeStore>(widget.ctx);
    // target = Provider.of<TargetStore>(widget.ctx);
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var rule = Provider.of<RuleStore>(context);

    if (rule.operationType == 1) {
      _name.text = rule.modifyData.name!;
      _port.text = rule.modifyData.port!.toString();
      _node.text = rule.modifyData.nodeId!;
      _matchType.text = rule.modifyData.matchType.toString();
      _targetId.text = rule.modifyData.targetId!;
      _targetRoute.text = rule.modifyData.targetRoute!;
      _mark.text = rule.modifyData.mark!;
    }

    return Container(
      height: 600,
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
                formFieldItem('匹配规则', _name, '请填写匹配规则', isHaveTo: true),
                // formFieldItem('端口号', _port, '请选择端口号', isHaveTo: true),
                // formSelectFieldItem('端口号', _port, '请选择端口号'),
                formSelectFieldItem(widget.list, '测试', _port, '123123'),
                formFieldItem('节点', _node, '请选择节点'),
                formFieldItem('目标地址', _targetId, '请填写目标地址', isHaveTo: true),
                formFieldItem('目标路由', _targetRoute, '请填写目标路由'),
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
                  // await SmartDialog.dismiss(tag: widget.tag, result: false);
                  GoRouter.of(context).pop();
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '确定',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    if (rule.operationType == 0) {
                      rule.createData.name = _name.text;
                      rule.createData.mark = _mark.text;

                      await rule.create();
                      await SmartDialog.dismiss(tag: widget.tag, result: true);
                    }

                    if (rule.operationType == 1) {
                      rule.modifyData.name = _name.text;
                      rule.modifyData.mark = _mark.text;
                      await rule.modify();
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


Future<bool> addRule() async {
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'add_rule',
    builder: (context) {
      var port = Provider.of<PortStore>(context);
      List<SelectOption> list = [];
      for (var element in port.data!.data!) {
        list.add(SelectOption(element.id!, element.port.toString()));
      }

      return RuleDialog(list: list, tag: 'add_rule', title: '添加匹配规则');
    },
  );

  return result;
}

Future<bool> editRule() async {
  
  var result = await SmartDialog.show(
    clickMaskDismiss: false,
    tag: 'edit_rule',
    builder: (context) {
      var port = Provider.of<PortStore>(context);
      List<SelectOption> list = [];
      for (var element in port.data!.data!) {
        list.add(SelectOption(element.id!, element.port.toString()));
      }

      return RuleDialog(list: list, tag: 'edit_rule', title: '修改匹配规则');
    },
  );

  return result;
}
