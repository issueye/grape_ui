import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatefulWidget {
  CustomTextField(
      {Key? key, required this.controller, this.suffixIcon, this.hintText})
      : super(key: key);
  final TextEditingController controller;
  IconData? suffixIcon;
  String? hintText;

  @override
  // ignore: library_private_types_in_public_api
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final FocusNode _focusNode = FocusNode();
  Color search = AppTheme.enabledColor;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          search = AppTheme.mainColor;
        });
      } else {
        setState(() {
          search = AppTheme.enabledColor;
        });
      }
    });
  }

  @override
  void dispose() {
    _focusNode.unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppTheme.mainColor,
      focusNode: _focusNode,
      controller: widget.controller,
      // 内容的字体
      style: AppTheme.defaultTextStyle,
      decoration: InputDecoration(
        // 内容内边距
        contentPadding: AppTheme.defaultTextFieldContentPadding,
        isCollapsed: true,
        hintText: widget.hintText,
        // 提示文字
        hintStyle: const TextStyle(
          color: AppTheme.hintColor,
          fontSize: AppTheme.defaultFontSize,
        ),
        // 边框
        border: const OutlineInputBorder(
          borderRadius: AppTheme.mainRadius,
        ),
        // 聚焦时的边框
        focusedBorder: const OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppTheme.mainColor,
          ),
          borderRadius: AppTheme.mainRadius,
        ),
        // 失去焦点时的边框
        enabledBorder: const OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppTheme.enabledColor,
          ),
          borderRadius: AppTheme.mainRadius,
        ),
        errorBorder: const OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(
            color: AppTheme.errorContentTextColor,
          ),
          borderRadius: AppTheme.mainRadius,
        ),
        // isDense: true,
      ),
    );
  }
}
