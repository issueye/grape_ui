import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomVerticalDivider extends StatefulWidget {
  const CustomVerticalDivider(
      {super.key, this.color = Colors.grey, this.height = 25, this.width = 1});
  final Color color;
  final double height;
  final double width;

  @override
  State<CustomVerticalDivider> createState() => _CustomVerticalDividerState();
}

class _CustomVerticalDividerState extends State<CustomVerticalDivider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppTheme.defaultAppBarHeight,
      decoration: const BoxDecoration(
        color: AppTheme.mainColor,
      ),
      child: Container(
        width: 1,
        height: 25,
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        color: widget.color,
      ),
    );
  }
}
