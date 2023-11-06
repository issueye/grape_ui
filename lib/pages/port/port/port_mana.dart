import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_text_field.dart';
import 'package:go_grape_ui/pages/port/port/port_item.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/rule_store.dart';
import 'package:provider/provider.dart';

import '../../../utils/app_theme.dart';
import 'port_dialog.dart';

class Port extends StatefulWidget {
  const Port({super.key});

  @override
  State<Port> createState() => _PortState();
}

class _PortState extends State<Port> {
  final TextEditingController _qryControl = TextEditingController();

  late PortStore port = PortStore();
  late NodeStore node = NodeStore();
  late RuleStore rule = RuleStore();

  Future<void> _getRepoList() async {
    await port.list();
  }

  @override
  void initState() {
    super.initState();
    port = Provider.of<PortStore>(context, listen: false);
    node = Provider.of<NodeStore>(context, listen: false);
    rule = Provider.of<RuleStore>(context, listen: false);
    _getRepoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: _qryControl,
                    hintText: '端口号',
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                    onPressed: () async {
                      await port.list();
                    },
                    name: '查询'),
                const SizedBox(width: 10),
                CustomButton(
                    onPressed: () async {
                      port.operationType = 0;
                      var isOk = await addPort();
                      if (isOk) {
                        await port.list();
                      }
                    },
                    name: '添加'),
              ],
            ),
            const SizedBox(height: 30),
            // 端口号列表
            Expanded(
              child: Consumer<PortStore>(
                builder: (context, value, child) {
                  return _getPort();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getPort() {
    return ListView.builder(
        itemCount: port.data == null ? 0 : port.data!.data!.length,
        itemBuilder: (context, index) {
          var data = port.data!.data!;
          if (data.isNotEmpty) {
            return PortItem(
              data: data[index],
              isSelect: port.selectIndex == index,
              onSelect: () {
                port.selectIndex = index;
                port.port = data[index].port!;
                node.portId = data[index].id!;
                rule.portId = data[index].id!;
              },
            );
          } else {
            return const Center(
              child: Text('没有数据', style: AppTheme.defaultTextStyle),
            );
          }
        });
  }
}
