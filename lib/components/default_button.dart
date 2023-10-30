import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class PlainButton extends StatefulWidget {
  const PlainButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.color = Colors.white,
    this.padding = AppTheme.defaultButtonPadding,
  });
  final Function()? onPressed;
  final String name;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  State<PlainButton> createState() => _PlainButtonState();
}

class _PlainButtonState extends State<PlainButton> {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0, 
        backgroundColor: widget.color,
        padding: AppTheme.defaultButtonPadding,
        textStyle: const TextStyle(
          fontSize: AppTheme.defaultFontSize,
          fontFamily: AppTheme.defaultFontFamily,
          fontWeight: AppTheme.defaultFontWeight,
        ),
        shape: const RoundedRectangleBorder(borderRadius: AppTheme.mainRadius),
      ),
      onPressed: widget.onPressed,
      child: Text(widget.name),
    );
  }
}

class DangerPlainButton extends PlainButton {
  const DangerPlainButton(
      {super.key, required super.onPressed, required super.name});

  @override
  State<DangerPlainButton> createState() => _DangerPlainButtonState();
}

class _DangerPlainButtonState extends State<DangerPlainButton> {
  @override
  Widget build(BuildContext context) {
    return PlainButton(
      onPressed: widget.onPressed,
      name: widget.name,
      color: AppTheme.dangerColor,
    );
  }
}

class WarnPlainButton extends PlainButton {
  const WarnPlainButton(
      {super.key, required super.onPressed, required super.name});

  @override
  State<WarnPlainButton> createState() => _WarnPlainButtonState();
}

class _WarnPlainButtonState extends State<WarnPlainButton> {
  @override
  Widget build(BuildContext context) {
    return PlainButton(
      onPressed: widget.onPressed,
      name: widget.name,
      color: AppTheme.warnColor,
    );
  }
}
