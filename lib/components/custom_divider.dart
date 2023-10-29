import 'package:flutter/material.dart';
import 'package:go_grape_ui/utils/app_theme.dart';

class CustomDivider extends StatefulWidget {
  const CustomDivider(
      {super.key, this.space = 10, this.color = AppTheme.dividerColor});
  final double space;
  final Color color;
  // final
  @override
  State<CustomDivider> createState() => _CustomDividerState();
}

class _CustomDividerState extends State<CustomDivider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: widget.space),
        Divider(
          height: 1,
          color: widget.color,
        ),
        SizedBox(height: widget.space),
      ],
    );
  }
}
