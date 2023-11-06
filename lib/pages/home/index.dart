import 'package:go_grape_ui/components/menu/menu.dart';
import 'package:go_grape_ui/pages/about/index.dart';
import 'package:go_grape_ui/pages/cert/cert_mana.dart';
import 'package:go_grape_ui/pages/home/win_title.dart';
import 'package:go_grape_ui/pages/port/main.dart';
import 'package:go_grape_ui/pages/settings/index.dart';
import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/target/target_mana.dart';
import 'package:logging/logging.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 主菜单
  final List<MenuItemData> menus = [
    MenuItemData('端口号管理', Icons.apps, Icons.apps_outlined),
    MenuItemData('地址管理', Icons.webhook, Icons.webhook_outlined),
    MenuItemData('证书管理', Icons.credit_card, Icons.credit_card_outlined),
  ];

  // 其他菜单
  final List<MenuItemData> footers = [
    MenuItemData('设置', Icons.settings, Icons.settings_outlined),
    MenuItemData('关于', Icons.question_answer, Icons.question_answer_outlined),
  ];

  final PageController _selectControl = PageController();

  final List pages = [
    const PortMain(),
    const TargetMana(),
    const CertMana(),
    const SettingsPage(),
    const AboutPage(),
  ];

  Logger log = Logger('home-> index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const WinTitle(),
          Expanded(
            child: IntrinsicHeight(
              child: Row(
                children: [
                  NavMenu(
                    width: 150,
                    onSelect: (index, type) {
                      log.info('select now = $index type = $type');
                      if (type == MenuOperationType.main) {
                        _selectControl.jumpToPage(index);
                      } else {
                        _selectControl.jumpToPage(index + menus.length);
                      }
                    },
                    menuList: menus,
                    footerList: footers,
                  ),
                  Expanded(
                    child: PageView.builder(
                      controller: _selectControl,
                      itemBuilder: (context, index) {
                        return pages[index];
                      },
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
