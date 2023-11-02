import 'package:flutter/material.dart';
import 'package:go_grape_ui/model/port/datum.dart';
import 'package:provider/provider.dart';

import '../../components/bar_button.dart';
import '../../components/message_dialog.dart';
import '../../store/port_store.dart';
import '../../utils/app_theme.dart';
import 'port/port_dialog.dart';

// ignore: must_be_immutable
class ItemButton extends StatelessWidget {
  ItemButton({super.key, required this.data});
  Datum data;

  final SizedBox _cardTileSpace = const SizedBox(width: 10);
  final _radius = const BorderRadius.all(Radius.circular(5));

  _roundDot(bool state) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: state ? AppTheme.successColor : AppTheme.dangerColor,
        borderRadius: _radius,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var port = Provider.of<PortStore>(context);
    debugPrint('端口号 ${data.port} -> 状态 ${data.state}');
    return Row(
      children: [
        _cardTileSpace,
        _roundDot(data.state!),
        _cardTileSpace,
        Text(
          '端口号 ${data.port.toString()}',
          style: AppTheme.sizeTextStyle(16),
        ),
        const Spacer(),
        BarButton(
          icon: data.state!
              ? Resources.restart()
              : Resources.restart(color: AppTheme.dangerColor),
          tipMessage: data.state! ? '使用中，点击停用' : '停用中，点击启用',
          onTap: () async {
            await port.modifyState(data.id!);
            await port.list();
          },
        ),
        const SizedBox(width: 10),
        BarButton(
          icon: Resources.edit,
          tipMessage: '编辑',
          onTap: () async {
            port.operationType = 1;
            port.modifyData = data;
            await editPort();
            await port.list();
          },
        ),
        const SizedBox(width: 10),
        BarButton(
            icon: Resources.delete,
            tipMessage: '删除',
            onTap: () async {
              await showMessageBox('删除', '''是否删除 ${data.port.toString()} ?''')
                  .then((value) async {
                if (value) {
                  await port.delete(data.id!);
                  await port.list();
                }
              });
            }),
        _cardTileSpace,
      ],
    );
  }
}
