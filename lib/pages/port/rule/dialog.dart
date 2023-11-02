import 'package:flutter/material.dart';
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
  });
  String tag;
  String title;

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

  late RuleStore port;

  @override
  void initState() {
    super.initState();
    port = Provider.of<RuleStore>(context, listen: false);
    port.list();
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

    return Scaffold(
      body: Container(
        // height: 600,
        // width: 500,
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
                  formFieldItem('匹配规则', _name, '请填写匹配规则', isHaveTo: true),
                  // formFieldItem('端口号', _port, '请选择端口号', isHaveTo: true),
                  // formSelectFieldItem('端口号', _port, '请选择端口号'),
                  Consumer<PortStore>(
                    builder: (context, value, child) {
                      List<SelectOption> list = [];

                      if (value.data != null) {
                        for (var element in value.data!.data!) {
                          list.add(
                            SelectOption(element.id!, element.port.toString()),
                          );
                        }
                      }

                      return formSelectFieldItem(list, '端口号', _port, '请选择端口号',
                          ((key, value) {
                        setState(() {
                          _port.text = value;
                        });
                      }));
                    },
                  ),

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
                  onPressed: () {
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
                      }

                      if (rule.operationType == 1) {
                        rule.modifyData.name = _name.text;
                        rule.modifyData.mark = _mark.text;
                        await rule.modify();
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
      ),
    );
  }
}
