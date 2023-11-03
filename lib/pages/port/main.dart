import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';
import 'node/node_mana.dart';
import 'rule/rule_mana.dart';
import 'port/port_mana.dart';

class PortMain extends StatefulWidget {
  const PortMain({super.key});

  @override
  State<PortMain> createState() => _PortMainState();
}

class _PortMainState extends State<PortMain> {
  int selectTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          const SizedBox(width: 300, child: Port()),
          // 分割线
          Container(width: 1, color: AppTheme.dividerColor),
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
                    RuleMana(),
                    NodeMana(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
