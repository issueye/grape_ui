import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/model/node/node.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../components/custom_button.dart';
import '../../../components/custom_table.dart';
import '../../../components/custom_text_field.dart';
import '../../../components/custom_toast.dart';
import '../../../components/message_dialog.dart';
import '../../../utils/db/config.dart';
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
    FieldInfo(title: '备注', name: 'mark'),
    FieldInfo(
      title: '操作',
      name: '操作',
      width: 130,
      titleCenter: true,
      child: (ctx, index, value) {
        var node = Provider.of<NodeStore>(ctx);
        var port = Provider.of<PortStore>(ctx);
        var data = node.data!.data![index];

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarButton(
              icon: Resources.jump,
              tipMessage: '从浏览器打开',
              onTap: () async {
                debugPrint(data.toString());
                var host = await ConfigDB.getStr('server_host');
                final url = Uri.parse(host);
                final targetUrl = Uri.parse('http://${url.host}:${port.port}/${data.name.toString()}/web/'); 
                if (!await launchUrl(targetUrl)) {
                  throw Exception('无法打开 ${targetUrl.toString()}');
                }
                Toast.Success('从浏览器打开成功');
              },
            ),
            const SizedBox(width: 10),
            BarButton(
              icon: Resources.copy,
              tipMessage: '复制',
              onTap: () async {
                debugPrint(data.toString());
                var host = await ConfigDB.getStr('server_host');
                final url = Uri.parse(host);
                Clipboard.setData(ClipboardData(text: 'http://${url.host}:${port.port}/${data.name.toString()}/web/'));
                Toast.Success('复制成功');
              },
            ),
            const SizedBox(width: 10),
            BarButton(
              icon: Resources.edit,
              tipMessage: '编辑',
              onTap: () async {
                node.modifyData = data;
                node.operationType = 1;
                debugPrint(data.toString());
                await GoRouter.of(ctx)
                    .pushNamed(Routes.nodeFormNamed, extra: '修改页面信息');
                await node.list();
              },
            ),
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
              },
            ),
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
                  GoRouter.of(context)
                      .pushNamed(Routes.nodeFormNamed, extra: '添加页面信息');
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
