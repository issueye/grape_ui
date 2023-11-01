import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/model/cert/cert.dart';
import 'package:go_grape_ui/pages/port/node_dialog.dart';
import 'package:go_grape_ui/store/cert_store.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import '../../components/message_dialog.dart';
import '../../components/custom_table.dart';

class CertMana extends StatefulWidget {
  const CertMana({super.key});

  @override
  State<CertMana> createState() => _CertManaState();
}

class _CertManaState extends State<CertMana> {
  final TextEditingController _qryControl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  final List<FieldInfo> fieldList = [
    FieldInfo(title: '名称', name: 'name', width: 100),
    FieldInfo(title: '公钥地址', name: 'public'),
    FieldInfo(title: '私钥地址', name: 'private'),
    FieldInfo(title: '备注', name: 'mark'),
    FieldInfo(
      title: '操作',
      name: '操作',
      width: 100,
      titleCenter: true,
      child: (ctx, index, value) {
        var cert = Provider.of<CertStore>(ctx);
        var data = cert.data!.data![index];
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BarButton(
                icon: Resources.edit,
                tipMessage: '编辑',
                onTap: () async {
                  cert.modifyData = data;
                  cert.operationType = 1;
                  debugPrint(data.toString());
                  var isOk = await editNode();
                  if (isOk) {
                    cert.list();
                  }
                }),
            const SizedBox(width: 10),
            BarButton(
                icon: Resources.delete,
                tipMessage: '删除',
                onTap: () async {
                  await showMessageBox('删除', '''是否删除 ${data.name} ?''')
                      .then((value) async {
                    if (value) {
                      await cert.delete(data.id!);
                      await cert.list();
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
    var cert = Provider.of<CertStore>(context);
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
                  await cert.list(condition: _qryControl.text);
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '添加',
                onPressed: () async {
                  cert.operationType = 0;
                  var isOk = await addNode();
                  if (isOk) {
                    await cert.list();
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          Expanded(
            child: Consumer<CertStore>(
              builder: (context, value, child) {
                // 表格头部
                return CustomTable<Cert>(
                  fieldInfo: fieldList,
                  tableData: cert.data,
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
