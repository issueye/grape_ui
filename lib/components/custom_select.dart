import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class SelectOption {
  String key;
  String value;
  SelectOption(this.key, this.value);
}

typedef valueChanged = Function(String, String)?;

// ignore: must_be_immutable
class CustomSelect extends StatefulWidget {
  CustomSelect({
    Key? key,
    this.hint,
    this.validText,
    required this.data,
    this.onChanged,
    required this.selectData,
    this.title = '',
    this.titleWidth = 70,
    this.height = 70,
    this.isHaveTo = false,
  }) : super(key: key);
  final String? hint;
  final String? validText;
  final String title;
  final double titleWidth;
  final double height;
  final List<SelectOption> data;
  final TextEditingController selectData;
  bool isHaveTo;
  valueChanged? onChanged;
  

  @override
  // ignore: library_private_types_in_public_api
  _CustomSelectState createState() => _CustomSelectState();
}

class _CustomSelectState extends State<CustomSelect> {
  late String _selectValue = '';
  final padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 8);

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
        ),
      );
    }

    return items;
  }

  _iconButton(IconData icon) {
    return Icon(
      icon,
      size: 15,
      color: AppTheme.defaultContentTextColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    _border(Color color) {
      return OutlineInputBorder(
          gapPadding: 0,
          borderSide: BorderSide(color: color),
          borderRadius: AppTheme.mainRadius);
    }

    // ignore: no_leading_underscores_for_local_identifiers
    _hintText() {
      return Text(
        widget.selectData.text == '' ? widget.hint! : widget.selectData.text,
        style: widget.selectData.text == ''
            ? AppTheme.sizeTextStyle(12, color: AppTheme.hintColor)
            : AppTheme.defaultTextStyle,
      );
    }

    String _getItemByKey(String key) {
      for (var element in widget.data) {
        if (element.key == key) return element.value;
      }

      return '';
    }

    return SizedBox(
      height: widget.height,
      child: Column(
        children: [
          Expanded(
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: padding,
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
                border: _border(AppTheme.mainColor),
                focusedBorder: _border(AppTheme.mainColor), // 聚焦时的边框
                enabledBorder: _border(AppTheme.enabledColor), // 失去焦点时的边框
                errorBorder: _border(AppTheme.errorContentTextColor),
              ),
              items: _getItems(),
              validator: (value) {
                if (!widget.isHaveTo) return null;
                return widget.selectData.text == '' ? widget.validText : null;
              },
              // 下拉框样式
              dropdownStyleData: const DropdownStyleData(
                offset: Offset(1, -10),
                decoration: BoxDecoration(borderRadius: AppTheme.mainRadius),
              ),
              // 下拉框项目样式
              menuItemStyleData: const MenuItemStyleData(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                height: 28,
              ),
              onChanged:(value) {
                debugPrint('value $value');
                var val = _getItemByKey(value.toString());
                setState(() {
                  widget.selectData.text = val;
                });
              },
              customButton: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _hintText(),
                  widget.selectData.text == ''
                      ? _iconButton(Icons.arrow_drop_down_outlined)
                      : InkWell(
                          onTap: () {
                            widget.selectData.text = '';
                            setState(() {});
                          },
                          child: _iconButton(Icons.close_outlined)),
                ],
              ),
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

formSelectFieldItem(
  List<SelectOption> list,
  String name,
  TextEditingController control,
  String hint,
  {
  valueChanged onChanged,
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
          titleWidth: titleWidth,
          data: list,
          selectData: control,
          isHaveTo: isHaveTo,
          hint: hint,
          validText: hint,
          onChanged: onChanged,
        ),
      ),
      SizedBox(width: space),
    ],
  );
}
