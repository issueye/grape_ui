import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/port/node_dialog.dart';

import '../../components/custom_button.dart';
import '../../components/custom_text_field.dart';
import 'node_table.dart';

class NodeMana extends StatefulWidget {
  const NodeMana({super.key});

  @override
  State<NodeMana> createState() => _NodeManaState();
}

class _NodeManaState extends State<NodeMana> {
  final TextEditingController _qryControl = TextEditingController();

  final List<FieldInfo> fieldList = [
    FieldInfo(name: '名称', width: 100),
    FieldInfo(name: '类型', width: 50),
    FieldInfo(name: '目标地址'),
    FieldInfo(name: '页面地址'),
    FieldInfo(name: '备注'),
    FieldInfo(name: '操作', width: 100),
  ];

  @override
  Widget build(BuildContext context) {
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
                  // await portStore.list();
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                name: '添加',
                onPressed: () async {
                  var isOk = await addNode();
                  // var isOk = await addPort();
                  // if (isOk) {
                  //   await portStore.list();
                  // }
                },
              ),
            ],
          ),
          const SizedBox(height: 30),
          // 表格头部
          NodeTable(fieldInfo: fieldList),
          const Spacer(),
        ],
      ),
    );
  }
}
