import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class SelectOption {
  String key;
  String value;
  SelectOption(this.key, this.value);
}

class CustomSelect extends StatefulWidget {
  const CustomSelect({
    Key? key,
    this.hint,
    this.validText,
    required this.data,
    this.onChanged,
    required this.selectData,
    this.title = '',
    this.titleWidth = 70,
    this.height = 70,
  }) : super(key: key);
  final String? hint;
  final String? validText;
  final String title;
  final double titleWidth;
  final double height;
  final List<SelectOption> data;
  final Function(dynamic key, dynamic value)? onChanged;
  final TextEditingController selectData;

  @override
  // ignore: library_private_types_in_public_api
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  late dynamic value;

  List<DropdownMenuItem<String>> _getItems() {
    List<DropdownMenuItem<String>> items = [];
    for (var element in widget.data) {
      items.add(
        DropdownMenuItem(
          value: element.key,
          child: Text(
            element.value,
            style: AppTheme.defaultTextStyle,
          ),
          onTap: () {
            value = element.value;
          },
        ),
      );
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    Text hintText = widget.hint == null
        ? const Text('')
        : Text(widget.hint!, style: AppTheme.defaultTextStyle);

    // ignore: no_leading_underscores_for_local_identifiers
    _border(Color color) {
      return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(color: color),
          borderRadius: AppTheme.mainRadius);
    }

    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: DropdownButtonFormField2(
              isExpanded: true,
              decoration: InputDecoration(
                isCollapsed: true,
                icon: SizedBox(
                  width: widget.titleWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.title, style: AppTheme.defaultTextStyle),
                    ],
                  ),
                ),
                contentPadding: AppTheme.defaultTextFieldContentPadding,
                border: _border(AppTheme.mainColor),
                focusedBorder: _border(AppTheme.mainColor), // 聚焦时的边框
                enabledBorder: _border(AppTheme.enabledColor), // 失去焦点时的边框
                errorBorder: _border(AppTheme.errorContentTextColor),
              ),
              hint: hintText,
              items: _getItems(),
              validator: (value) {
                if (value == null) {
                  return widget.validText == null ? '' : widget.validText!;
                }
                return null;
              },
              dropdownStyleData: const DropdownStyleData(
                offset: Offset(1, 30),
                decoration: BoxDecoration(
                  borderRadius: AppTheme.mainRadius,
                ),
              ),
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                height: 28,
              ),
              onChanged: ((val) {
                widget.onChanged!(val, value);
              }),
              customButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.selectData.text == ''
                        ? widget.hint!
                        : widget.selectData.text,
                    style: AppTheme.defaultTextStyle,
                  ),
                  widget.selectData.text == ''
                      ? const Icon(
                          Icons.arrow_drop_down_outlined,
                          color: AppTheme.defaultContentTextColor,
                        )
                      : InkWell(
                          onTap: () {
                            widget.selectData.text = '';
                            setState(() {});
                          },
                          child: const Icon(
                            Icons.close_outlined,
                            size: 15,
                            color: AppTheme.defaultContentTextColor,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

formSelectFieldItem(
  List<SelectOption> list,
  String name,
  TextEditingController control,
  String hint,
  dynamic Function(dynamic, dynamic)? onChanged, {
  bool isHaveTo = false,
  int line = 1,
  double space = 30,
  double titleWidth = 55,
}) {
  return Row(
    children: [
      SizedBox(width: space),
      Expanded(
        child: CustomSelect(
          title: name,
          data: list,
          selectData: control,
          hint: hint,
          onChanged: onChanged,
        ),
      ),
      SizedBox(width: space),
    ],
  );
}
