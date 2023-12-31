import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_toast.dart';
import 'package:go_grape_ui/model/port/datum.dart';
import 'package:provider/provider.dart';

import '../../../components/bar_button.dart';
import '../../../components/message_dialog.dart';
import '../../../store/port_store.dart';
import '../../../utils/app_theme.dart';
import 'port_dialog.dart';

// ignore: must_be_immutable
class ItemButton extends StatelessWidget {
  ItemButton({super.key, required this.data});
  Datum data;

  final SizedBox _cardTileSpace = const SizedBox(width: 10);
  final _radius = const BorderRadius.all(Radius.circular(5));

  _roundDot(bool state, {double size = 10}) {
    return Container(
      width: size,
      height: size,
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
        _roundDot(data.state!, size: 8),
        _cardTileSpace,
        Text(
          data.port.toString(),
          style: AppTheme.sizeTextStyle(16),
        ),
        const Spacer(),
        BarButton(
          icon: Resources.start(),
          tipMessage: '启用端口号',
          onTap: () async {
            var res = await port.start(data.id!);
            if (res!.code != 200) {
              Toast.Error(res.message.toString());
            } else {
              await port.list();
              Toast.Success('启用端口号成功');
            }
          },
        ),
        const SizedBox(width: 10),
        BarButton(
          icon: Resources.stop(),
          tipMessage: '停用端口号',
          onTap: () async {
            var res = await port.stop(data.id!);
            if (res!.code != 200) {
              Toast.Error(res.message.toString());
            } else {
              await port.list();
              Toast.Success('停用端口号成功');
            }
          },
        ),
        const SizedBox(width: 10),
        BarButton(
          icon: Resources.restart(),
          tipMessage: '重启端口号',
          onTap: () async {
            await port.reload(data.id!);
            await port.list();
            Toast.Success('重启端口号[${data.port.toString()}]成功');
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
              await showMessageBox('删除', '''
      删除端口将删除端口下的所有匹配规则
      和节点，是否删除端口 ${data.port.toString()} ?''')
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
