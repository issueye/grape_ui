import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_text_field.dart';
import 'package:go_grape_ui/pages/port/port_item.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:provider/provider.dart';

import '../../utils/app_theme.dart';
import 'port_dialog.dart';

class Port extends StatefulWidget {
  const Port({super.key});

  @override
  State<Port> createState() => _PortState();
}

class _PortState extends State<Port> {
  final TextEditingController _qryControl = TextEditingController();

  late PortStore portStore = PortStore();

  Future<void> _getRepoList() async {
    await portStore.list();
  }

  @override
  void initState() {
    super.initState();
    portStore = Provider.of<PortStore>(context, listen: false);
    _getRepoList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    await portStore.list();
                  },
                  name: '查询'),
              const SizedBox(width: 10),
              CustomButton(
                  onPressed: () async {
                    var isOk = await addPort();
                    if (isOk) {
                      await portStore.list();
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
    );
  }

  _getPort() {
    return ListView.builder(
        itemCount: portStore.data == null ? 0 : portStore.data!.data!.length,
        itemBuilder: (context, index) {
          var data = portStore.data!.data!;
          if (data.isNotEmpty) {
            return PortItem(
              data: data[index],
              isSelect: portStore.selectIndex == index,
              onSelect: () {
                portStore.selectIndex = index;
                // repo.selectRepoId = data[index].id;
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
