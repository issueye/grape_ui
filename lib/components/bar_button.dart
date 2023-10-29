import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_grape_ui/utils/app_theme.dart';

// ignore: must_be_immutable
class BarButton extends StatefulWidget {
  BarButton(
      {super.key,
      this.size = 20,
      this.tipMessage = '',
      required this.icon,
      required this.onTap});
  double size;
  String tipMessage;
  SvgPicture icon;
  Function()? onTap;

  @override
  State<BarButton> createState() => _BarButtonState();
}

class _BarButtonState extends State<BarButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: widget.onTap,
      child: Tooltip(
        textStyle: AppTheme.lightTextStyle,
        message: widget.tipMessage,
        preferBelow: false,
        verticalOffset: 8,
        child: Container(
          padding: const EdgeInsets.all(3),
          height: widget.size,
          width: widget.size,
          child: widget.icon,
        ),
      ),
    );
  }
}
