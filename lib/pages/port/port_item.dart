import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/bar_button.dart';
import 'package:go_grape_ui/pages/port/port_dialog.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../components/message_dialog.dart';
import '../../model/port_list/datum.dart';

class PortItem extends StatefulWidget {
  const PortItem(
      {super.key, required this.data, this.isSelect = false, this.onSelect});
  final Datum data;
  final bool isSelect;
  final Function()? onSelect;

  @override
  State<PortItem> createState() => _PortItemState();
}

class _PortItemState extends State<PortItem> {
  bool isHover = false;
  final SizedBox _cardTileHeight = const SizedBox(height: 10);
  final SizedBox _cardTileSpace = const SizedBox(width: 10);

  Color _getBorderColor(int type) {
    switch (type) {
      case 0:
        return Colors.blue;
      case 1:
        return AppTheme.mainColor;
      default:
        return AppTheme.dividerColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    var portStore = Provider.of<PortStore>(context);
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: InkWell(
        hoverColor: const Color.fromARGB(166, 240, 239, 242),
        borderRadius: BorderRadius.circular(4),
        onTap: widget.onSelect,
        onHover: (value) {
          setState(() {
            isHover = value;
          });
        },
        child: Consumer<PortStore>(
          builder: (context, value, child) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: _getBorderColor(widget.isSelect
                        ? 0
                        : isHover
                            ? 1
                            : 2),
                    width: 1),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Column(
                children: [
                  _cardTileHeight,
                  _barButtons(portStore),
                  _cardTileHeight,
                  Container(
                    height: 1,
                    color: AppTheme.dividerColor,
                  ),
                  const SizedBox(height: 10),
                  _itemText('创建时间 ${widget.data.createdAt!}', ''),
                  const SizedBox(height: 5),
                  _itemText('备　　注 ${widget.data.mark}', widget.data.mark!),
                  _cardTileHeight,
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _itemText(String txt, String message) {
    return Row(
      children: [
        _cardTileSpace,
        Expanded(
          child: Tooltip(
            preferBelow: false,
            verticalOffset: 8,
            message: message,
            child: Text(
              txt,
              maxLines: 1,
              style: AppTheme.sizeTextStyle(11),
              softWrap: false,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  _roundDot(bool state) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        color: state ? AppTheme.successColor : AppTheme.dangerColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
    );
  }

  _barButtons(PortStore port) {
    debugPrint('当前状态 ${widget.data.state!}');
    return Row(
      children: [
        _cardTileSpace,
        _roundDot(widget.data.state!),
        _cardTileSpace,
        Text(
          '端口号 ${widget.data.port.toString()}',
          style: AppTheme.sizeTextStyle(16),
        ),
        const Spacer(),
        BarButton(
          icon: widget.data.state! ? Resources.stop() : Resources.start(),
          tipMessage: widget.data.state! ? '使用中，点击停用' : '停用中，点击启用',
          onTap: () async {
            await editPort(widget.data);
          },
        ),
        const SizedBox(width: 10),
        BarButton(
          icon: Resources.edit,
          tipMessage: '编辑',
          onTap: () async {
            await editPort(widget.data);
          },
        ),
        const SizedBox(width: 10),
        BarButton(
            icon: Resources.delete,
            tipMessage: '删除',
            onTap: () async {
              await showMessageBox('删除', '''
是否删除 ${widget.data.port.toString()} ?
''').then((value) async {
                debugPrint('then -> $value');
                if (value) {
                  // await port.removeDataById(widget.data.id!);
                  // await port.getRepoList();
                }
              });
            }),
        _cardTileSpace,
      ],
    );
  }
}
