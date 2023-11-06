import 'package:flutter/material.dart';
import '../../utils/app_theme.dart';
import 'node/node_mana.dart';
import 'rule/rule_mana.dart';

class PortMainPage extends StatefulWidget {
  const PortMainPage({super.key});

  @override
  State<PortMainPage> createState() => _PortMainPageState();
}

class _PortMainPageState extends State<PortMainPage> {
  int selectTab = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
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
    );
  }
}
