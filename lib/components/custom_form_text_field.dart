import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomFormTextField extends StatefulWidget {
  CustomFormTextField({
    Key? key,
    required this.controller,
    this.suffixIcon,
    this.hintText,
    this.title = '',
    this.titleWidth = 40,
    this.height = 70,
    this.isHaveTo = false,
    this.lines = 1,
  }) : super(key: key);
  final TextEditingController controller;
  IconData? suffixIcon;
  String? hintText;
  String title;
  double titleWidth;
  double height;
  bool isHaveTo;
  int lines;

  @override
  // ignore: library_private_types_in_public_api
  _CustomFormTextFieldState createState() => _CustomFormTextFieldState();
}

class _CustomFormTextFieldState extends State<CustomFormTextField> {
  final FocusNode _focusNode = FocusNode();
  final padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 8);
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

  // 边框
  OutlineInputBorder _getBorder(Color color) {
    return OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(color: color),
      borderRadius: AppTheme.mainRadius,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: TextFormField(
              maxLines: widget.lines,
              cursorColor: AppTheme.mainColor,
              focusNode: _focusNode,
              controller: widget.controller,
              // 内容的字体
              style: AppTheme.defaultTextStyle,
              decoration: InputDecoration(
                // 前置标题
                icon: SizedBox(
                  width: widget.titleWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _haveTo(),
                      Text(widget.title, style: AppTheme.defaultTextStyle),
                    ],
                  ),
                ),
                isCollapsed: true,
                // 内容内边距
                contentPadding: padding,
                // 提示文字
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: AppTheme.hintColor,
                  fontSize: AppTheme.defaultFontSize,
                ),
                // 边框
                border: _getBorder(AppTheme.mainColor), // 边框
                focusedBorder: _getBorder(AppTheme.mainColor), // 聚焦时的边框
                enabledBorder: _getBorder(AppTheme.enabledColor), // 失去焦点时的边框
                errorBorder:
                    _getBorder(AppTheme.errorContentTextColor), // 错误时边框
              ),
              validator: (value) {
                if (!widget.isHaveTo) return null;

                if (value != null) {
                  if (value.isEmpty) {
                    return widget.hintText;
                  }
                  return null;
                }

                return widget.hintText;
              },
            ),
          ),
        ],
      ),
    );
  }

  _haveTo() {
    return widget.isHaveTo
        ? const Text('*', style: TextStyle(color: AppTheme.dangerColor))
        : Container();
  }
}

formFieldItem(
  String name,
  TextEditingController control,
  String hint, {
  bool isHaveTo = false,
  int line = 1,
  double space = 30,
  double titleWidth = 55,
}) {
  return Row(
    children: [
      SizedBox(width: space),
      Expanded(
        child: CustomFormTextField(
          controller: control,
          title: name,
          titleWidth: titleWidth,
          hintText: hint,
          isHaveTo: isHaveTo,
          lines: line,
        ),
      ),
      SizedBox(width: space),
    ],
  );
}