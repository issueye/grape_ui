import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.name,
    this.color = AppTheme.mainColor,
    this.padding = AppTheme.defaultButtonPadding,
  });
  final Function()? onPressed;
  final String name;
  final Color color;
  final EdgeInsetsGeometry padding;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        primary: widget.color,
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

class DangerButton extends CustomButton {
  const DangerButton(
      {super.key, required super.onPressed, required super.name});

  @override
  State<DangerButton> createState() => _DangerButtonState();
}

class _DangerButtonState extends State<DangerButton> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: widget.onPressed,
      name: widget.name,
      color: AppTheme.dangerColor,
    );
  }
}

class WarnButton extends CustomButton {
  const WarnButton({super.key, required super.onPressed, required super.name});

  @override
  State<WarnButton> createState() => _WarnButtonState();
}

class _WarnButtonState extends State<WarnButton> {
  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: widget.onPressed,
      name: widget.name,
      color: AppTheme.warnColor,
    );
  }
}

class RawButton extends StatefulWidget {
  const RawButton(
      {super.key,
      required this.name,
      this.onPressed,
      this.color = AppTheme.mainColor});
  final Function()? onPressed;
  final String name;
  final Color color;

  @override
  State<RawButton> createState() => _RawButtonState();
}

class _RawButtonState extends State<RawButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 16,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(widget.color), // 背景颜色
          foregroundColor: MaterialStateProperty.all(Colors.white), // 字体颜色
          overlayColor: MaterialStateProperty.all(widget.color), // 高亮颜色
          shadowColor: MaterialStateProperty.all(widget.color), // 阴影颜色
          elevation: MaterialStateProperty.all(0), // 阴影值
          textStyle: MaterialStateProperty.all(const TextStyle(
              fontSize: 11, fontFamily: AppTheme.defaultFontFamily)),
          shape: MaterialStateProperty.all(
            BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
          padding: MaterialStateProperty.all(
              const EdgeInsetsDirectional.symmetric(
                  horizontal: 2, vertical: 1)), //
        ),
        onPressed: widget.onPressed,
        child: Text(widget.name),
      ),
    );
  }
}
