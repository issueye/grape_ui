import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MenuItem extends StatefulWidget {
  MenuItem({
    super.key,
    required this.icon,
    required this.name,
    required this.onSelect,
    required this.activeIcon,
    this.isSelect = false,
  });
  final IconData icon;
  final IconData activeIcon;
  final String name;
  final Function() onSelect;
  bool isSelect;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width,
      margin: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(3),
        ),
      ),
      child: InkWell(
        onTap: widget.onSelect,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
          decoration: BoxDecoration(
            color:
                widget.isSelect ? const Color.fromARGB(40, 39, 118, 182) : null,
            borderRadius: const BorderRadius.all(
              Radius.circular(4),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 2,
                height: 15,
                color: widget.isSelect ? AppTheme.mainColor : null,
                child: const Text(''),
              ),
              const SizedBox(width: 5),
              SizedBox(
                width: 30,
                child: Icon(
                  widget.isSelect ? widget.activeIcon : widget.icon,
                  color: widget.isSelect
                      ? AppTheme.mainColor
                      : AppTheme.defaultContentTextColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontFamily: AppTheme.defaultFontFamily,
                    fontSize: AppTheme.defaultFontSize,
                    color: widget.isSelect
                        ? AppTheme.mainColor
                        : AppTheme.defaultContentTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
