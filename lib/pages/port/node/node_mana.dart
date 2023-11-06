import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/model/node/node.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_table.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/message_dialog.dart';
import '../route.dart';


class NodeMana extends StatefulWidget {
  const NodeMana({super.key});

  @override
  State<NodeMana> createState() => _NodeManaState();
}

class _NodeManaState extends State<NodeMana> {
  final TextEditingController _qryControl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final List<FieldInfo> fieldList = [
    FieldInfo(title: '名称', name: 'name', width: 100),
    FieldInfo(
      title: '类型',
      name: 'nodeType',
      width: 80,
      titleCenter: true,
      child: (ctx, index, value) {
        var val = value as int;
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Container(
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: val == 0
                  ? AppTheme.successColor.withOpacity(0.8)
                  : AppTheme.warnColor.withOpacity(0.8),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                val == 0 ? '接口' : '页面',
                style: AppTheme.sizeTextStyle(10, color: Colors.white),
              ),
            ),
          ),
        );
      },
    ),
    FieldInfo(title: '目标地址', name: 'target', clip: true),
    FieldInfo(title: '访问路径', name: 'pagePath', clip: true),
    FieldInfo(title: '备注', name: 'mark'),
    FieldInfo(
      title: '操作',
      name: '操作',
      width: 100,
      titleCenter: true,
      child: (ctx, index, value) {
        var node = Provider.of<NodeStore>(ctx);
        var data = node.data!.data![index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarButton(
                icon: Resources.edit,
                tipMessage: '编辑',
                onTap: () async {
                  node.modifyData = data;
                  node.operationType = 1;
                  debugPrint(data.toString());
                  await GoRouter.of(ctx).pushNamed(Routes.nodeFormNamed, extra: '修改节点信息');
                  await node.list();
                }),
            const SizedBox(width: 10),
            BarButton(
                icon: Resources.delete,
                tipMessage: '删除',
                onTap: () async {
                  await showMessageBox('删除', '''是否删除 ${data.name} ?''')
                      .then((value) async {
                    if (value) {
                      await node.delete(data.id!);
                      await node.list();
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
    var node = Provider.of<NodeStore>(context);
    return Container(
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
                  await node.list(condition: _qryControl.text);
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '添加',
                onPressed: () async {
                  node.operationType = 0;
                  GoRouter.of(context).pushNamed(Routes.nodeFormNamed, extra: '添加节点信息');
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Consumer<NodeStore>(
              builder: (context, value, child) {
                // 表格头部
                return CustomTable<Node>(
                  fieldInfo: fieldList,
                  tableData: node.data,
                  context: context,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
