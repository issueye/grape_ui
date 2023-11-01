import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/port/node_mana.dart';
import 'package:go_grape_ui/pages/port/rule_mana.dart';

import '../../utils/app_theme.dart';
import 'port_mana.dart';

class PortMana extends StatefulWidget {
  const PortMana({super.key});

  @override
  State<PortMana> createState() => _PortManaState();
}

class _PortManaState extends State<PortMana> {
  int selectTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 300,
          child: Port(),
        ),
        // 分割线
        Container(
          width: 1,
          color: AppTheme.dividerColor,
        ),
        Expanded(
          child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.white,
                shadowColor: Colors.white,
                title: Container(
                  margin: const EdgeInsets.only(top: 10),
                  height: 35,
                  child: TabBar(
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: AppTheme.mainColor.withOpacity(0.6),
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4)),
                    ),
                    tabs: [
                      Tab(
                          child: Text('匹配规则管理',
                              style: selectTab == 0
                                  ? AppTheme.lightTextStyle
                                  : AppTheme.defaultTextStyle)),
                      Tab(
                          child: Text('节点管理',
                              style: selectTab == 1
                                  ? AppTheme.lightTextStyle
                                  : AppTheme.defaultTextStyle)),
                    ],
                    onTap: (value) {
                      setState(() {
                        selectTab = value;
                      });
                    },
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  // Text('123'),
                  RuleMana(),
                  NodeMana(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
