import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/custom_select.dart';
import 'package:go_grape_ui/components/default_button.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/rule_store.dart';
import 'package:go_grape_ui/store/target_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final GlobalKey<FormState> formKey = GlobalKey<FormState>();

// ignore: must_be_immutable
class RuleDialog extends StatefulWidget {
  RuleDialog({
    super.key,
    required this.title,
    required this.port,
  });
  String title;
  int port;

  @override
  State<RuleDialog> createState() => _RuleDialogState();
}

class _RuleDialogState extends State<RuleDialog> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _port = TextEditingController();
  final TextEditingController _matchType = TextEditingController(text: 'GIN路由匹配');
  final TextEditingController _target = TextEditingController();
  final TextEditingController _targetRoute = TextEditingController();
  final TextEditingController _method = TextEditingController(text: 'ANY');
  final TextEditingController _mark = TextEditingController();

  late PortStore port;
  late TargetStore target;
  late NodeStore node;

  String _macthNum = '1';

  final List<SelectOption> methods = [
    SelectOption('GET', 'GET'),
    SelectOption('POST', 'POST'),
    SelectOption('PUT', 'PUT'),
    SelectOption('PATCH', 'PATCH'),
    SelectOption('DELETE', 'DELETE'),
    SelectOption('ANY', 'ANY'),
  ];

  final List<SelectOption> matchTypes = [
    SelectOption('1', 'GIN路由匹配'),
    SelectOption('2', 'MUX路由匹配'),
  ];

  Future<void> _getData() async {
    await target.list();
    await node.list();
  }

  String findMatchType(String key) {
    for (var i = 0; i < matchTypes.length; i++) {
      if (matchTypes[i].key == key) {
        return matchTypes[i].value;
      }
    }

    return '';
  }

  @override
  void initState() {
    super.initState();
    port = Provider.of<PortStore>(context, listen: false);
    target = Provider.of<TargetStore>(context, listen: false);
    node = Provider.of<NodeStore>(context, listen: false);

    _getData();
  }

  @override
  Widget build(BuildContext context) {
    var rule = Provider.of<RuleStore>(context);
    _port.text = widget.port.toString();

    if (rule.operationType == 1) {
      _name.text = rule.modifyData.name.toString();
      _method.text = rule.modifyData.method.toString();
      _matchType.text = findMatchType(rule.modifyData.matchType.toString());
      _target.text = target.getNameById(rule.modifyData.targetId!);
      _targetRoute.text = rule.modifyData.targetRoute.toString();
      _mark.text = rule.modifyData.mark.toString();
      _macthNum = rule.modifyData.matchType.toString();
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
              key: formKey,
              child: Column(
                children: [
                  formFieldItem('匹配规则', _name, '请填写匹配规则', isHaveTo: true),
                  Row(
                    children: [
                      Expanded(
                        child: formFieldItem('端口号', _port, '请选择端口号',
                            isHaveTo: true, enabled: false),
                      ),
                      Expanded(
                        child: formSelectFieldItem(
                          methods,
                          '请求方法',
                          _method,
                          '请选择请求方法',
                          onChanged: (key, value) {
                            _method.text = value.toString();
                          },
                          isHaveTo: true,
                        ),
                      ),
                    ],
                  ),
                  Consumer<NodeStore>(
                    builder: (context, value, child) {
                      List<SelectOption> list = [];

                      if (value.data != null) {
                        for (var element in value.data!.data!) {
                          list.add(
                            SelectOption(element.id!, element.name!),
                          );
                        }
                      }

                      return Row(
                        children: [
                          Expanded(
                            child: formSelectFieldItem(
                              matchTypes,
                              '匹配方式',
                              _matchType,
                              '请选择匹配方式',
                              onChanged: (key, value) {
                                debugPrint('key = $key value = $value');
                                _macthNum = value;
                                _matchType.text = key;
                              },
                              isHaveTo: true,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
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

                      return formSelectFieldItem(
                          list, '目标地址', _target, '请选择目标地址',
                          onChanged: (key, value) {
                        _target.text = key.toString();
                      }, isHaveTo: true);
                    },
                  ),
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
                    final form = formKey.currentState!;
                    if (form.validate()) {
                      if (rule.operationType == 0) {
                        rule.createData.name = _name.text;
                        rule.createData.mark = _mark.text;
                        rule.createData.method = _method.text;
                        rule.createData.portId = port.selectData.id;
                        rule.createData.nodeId = '';
                        rule.createData.targetId =
                            target.getIdByName(_target.text);
                        rule.createData.targetRoute = _targetRoute.text;
                        rule.createData.matchType = int.parse(_macthNum);
                        var isOk = await rule.create();
                        if (!isOk) return;
                      }

                      if (rule.operationType == 1) {
                        rule.modifyData.name = _name.text;
                        rule.modifyData.mark = _mark.text;
                        rule.modifyData.method = _method.text;
                        rule.modifyData.portId = port.selectData.id;
                        rule.modifyData.nodeId = '';
                        rule.modifyData.targetId =
                            target.getIdByName(_target.text);
                        rule.modifyData.targetRoute = _targetRoute.text;
                        rule.modifyData.matchType = int.parse(_macthNum);
                        debugPrint('修改信息: ${rule.modifyData}');
                        var isOk = await rule.modify();
                        if (!isOk) return;
                      }

                      await rule.list();
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
}
