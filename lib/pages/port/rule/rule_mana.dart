import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/rule_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/message_dialog.dart';
import '../../../components/custom_table.dart';
import '../route.dart';

class RuleMana extends StatefulWidget {
  const RuleMana({super.key});

  @override
  State<RuleMana> createState() => _RuleManaState();
}

class _RuleManaState extends State<RuleMana> {
  final TextEditingController _qryControl = TextEditingController();

  static final Map<String, Color> methodColors = {
    'GET': Colors.blue.shade800,
    'POST': Colors.green.shade800,
    'PUT': Colors.yellow.shade800,
    'DELETE': Colors.red.shade800,
    'PATCH': Colors.yellow.shade300,
    'ANY': Colors.teal.shade800,
  };

  @override
  void initState() {
    super.initState();
  }

  final List<FieldInfo> fieldList = [
    FieldInfo(title: '匹配规则', name: 'name', width: 200, clip: true),
    FieldInfo(
      title: '请求方法',
      name: 'method',
      width: 80,
      titleCenter: true,
      child: (ctx, index, value) {
        return flag(value, color: methodColors[value.toString()]);
      },
    ),
    FieldInfo(title: '节点', name: 'node', width: 130),
    FieldInfo(title: '目标地址', name: 'target', clip: true),
    FieldInfo(title: '目标路由', name: 'targetRoute', clip: true), 
    FieldInfo(title: '备注', name: 'mark'),
    FieldInfo(
      title: '操作',
      name: '操作',
      width: 100,
      titleCenter: true,
      child: (ctx, index, value) {
        var rule = Provider.of<RuleStore>(ctx);
        var port = Provider.of<PortStore>(ctx);
        var data = rule.data!.data![index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarButton(
                icon: Resources.edit,
                tipMessage: '编辑',
                onTap: () async {
                  rule.clear();
                  rule.modifyData = data;
                  rule.operationType = 1;
                  debugPrint(data.toString());
                  GoRouter.of(ctx).pushNamed(Routes.ruleFormNamed,
                      extra: RulePageParam(port.port, '添加匹配规则'));
                }),
            const SizedBox(width: 10),
            BarButton(
                icon: Resources.delete,
                tipMessage: '删除',
                onTap: () async {
                  await showMessageBox('删除', '''是否删除 ${data.name} ?''')
                      .then((value) async {
                    if (value) {
                      await rule.delete(data.id!);
                      await rule.list();
                    }
                  });
                }),
          ],
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var rule = Provider.of<RuleStore>(context);
    var port = Provider.of<PortStore>(context);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Wrap(
              alignment: WrapAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  child: CustomTextField(
                    controller: _qryControl,
                    hintText: '检索信息',
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  name: '查询',
                  onPressed: () async {
                    await rule.list(condition: _qryControl.text);
                  },
                ),
                const SizedBox(width: 10),
                CustomButton(
                  name: '添加',
                  onPressed: () async {
                    rule.operationType = 0;
                    rule.clear();
                    GoRouter.of(context).pushNamed(Routes.ruleFormNamed,
                        extra: RulePageParam(port.port, '添加匹配规则'));
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Expanded(
              child: Consumer<RuleStore>(
                builder: (context, value, child) {
                  // 表格头部
                  return CustomTable(
                    fieldInfo: fieldList,
                    tableData: rule.data,
                    context: context,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

flag(dynamic value, {Color? color = AppTheme.successColor}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    child: Container(
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: color == null
            ? Colors.teal.shade800.withOpacity(0.8)
            : color.withOpacity(0.8),
      ),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          value.toString(),
          style: AppTheme.sizeTextStyle(10, color: Colors.white),
        ),
      ),
    ),
  );
}
