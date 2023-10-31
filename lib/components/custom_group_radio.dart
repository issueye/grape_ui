import 'package:flutter/material.dart';
import 'package:go_grape_ui/utils/app_theme.dart';

// ignore: must_be_immutable
class CustomGroupRadio extends StatefulWidget {
  CustomGroupRadio({
    super.key,
    required this.items,
    this.title = '',
    this.height = 70,
    this.errorInfo,
    this.titleWidth = 40,
    this.isHaveTo = false,
    this.group = -1,
    required this.onChanged,
  });
  final List<String> items; // 项目
  final double height; // 高度
  final String? errorInfo; // 提示文字
  bool isHaveTo; //
  final String title; // 标题名称
  double titleWidth;
  int? group;
  Function(int?) onChanged;

  @override
  State<CustomGroupRadio> createState() => _CustomGroupRadioState();
}

class _CustomGroupRadioState extends State<CustomGroupRadio> {
  _haveTo() {
    return widget.isHaveTo
        ? const Text('*', style: TextStyle(color: AppTheme.dangerColor))
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    // 获取项目
    // ignore: no_leading_underscores_for_local_identifiers
    _item({String name = '', int value = 0}) {
      return Row(
        children: [
          Radio(
            splashRadius: 3,
            value: value,
            groupValue: widget.group,
            onChanged: (val) {
              setState(() {
                widget.group = val;
                widget.onChanged(val);
              });
            },
          ),
          Text(name, style: AppTheme.defaultTextStyle),
        ],
      );
    }

    // ignore: no_leading_underscores_for_local_identifiers
    List<Widget> _getItems() {
      List<Widget> items = [];

      items.add(
        SizedBox(
          width: widget.titleWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _haveTo(),
              Text(widget.title, style: AppTheme.defaultTextStyle),
            ],
          ),
        ),
      );

      items.add(const SizedBox(width: 10));

      for (var i = 0; i < widget.items.length; i++) {
        items.add(_item(name: widget.items[i], value: i));
        items.add(const SizedBox(width: 10));
      }

      return items;
    }

    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: _getItems(),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
