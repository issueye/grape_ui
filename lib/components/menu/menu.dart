import 'package:go_grape_ui/components/menu/item.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class NavMenu extends StatefulWidget {
  const NavMenu({
    super.key,
    required this.width,
    required this.onSelect,
    required this.menuList,
    this.footerList,
  });
  final double width;
  final Function(int, MenuOperationType) onSelect;
  final List<MenuItemData> menuList;
  final List<MenuItemData>? footerList;

  @override
  State<NavMenu> createState() => _NavMenuState();
}

enum MenuOperationType {
  main,
  footer,
}

class MenuItemData {
  String name;
  IconData icon;
  IconData activeIcon;

  MenuItemData(
    this.name,
    this.activeIcon,
    this.icon,
  );

  @override
  String toString() {
    return 'MenuItemData(name:$name, icon:$icon, activeIcon:$activeIcon)';
  }
}

class _NavMenuState extends State<NavMenu> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromARGB(141, 241, 236, 236),
        border: Border(
          right: BorderSide(
            width: 1,
            style: BorderStyle.solid,
            color: AppTheme.dividerColor,
          ),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              itemCount: widget.menuList.length,
              itemBuilder: (context, index) {
                final menu = widget.menuList[index];
                return MenuItem(
                  icon: menu.icon,
                  name: menu.name,
                  onSelect: () {
                    selectIndex = index;
                    widget.onSelect(selectIndex, MenuOperationType.main);
                    setState(() {});
                  },
                  isSelect: selectIndex == index,
                  activeIcon: menu.activeIcon,
                );
              },
            ),
          ),
          const Spacer(),
          const Divider(height: 1),
          const SizedBox(height: 5),
          // footers
          Expanded(
              child: ListView.builder(
            itemCount:
                widget.footerList != null ? widget.footerList!.length : 0,
            itemBuilder: (context, index) {
              final menu = widget.footerList![index];
              return MenuItem(
                icon: menu.icon,
                name: menu.name,
                onSelect: () {
                  selectIndex = index + widget.menuList.length;
                  widget.onSelect(selectIndex - widget.menuList.length,
                      MenuOperationType.footer);
                  setState(() {});
                },
                isSelect: selectIndex == index + widget.menuList.length,
                activeIcon: menu.activeIcon,
              );
            },
          )),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
