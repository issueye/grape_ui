import 'package:flutter/material.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:provider/provider.dart';

import '../../../model/port/datum.dart';
import '../bar_buttons.dart';

class PortItem extends StatefulWidget {
  const PortItem({
    super.key,
    required this.data,
    this.isSelect = false,
    this.onSelect,
  });
  final Datum data; // 数据
  final bool isSelect; // 选择
  final Function()? onSelect; // 选择事件

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
                  ItemButton(data: widget.data),
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
}
