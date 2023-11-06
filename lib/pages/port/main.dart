import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/port/route.dart';

import '../../utils/app_theme.dart';
import 'port/port_mana.dart';

class PortMain extends StatefulWidget {
  const PortMain({super.key});

  @override
  State<PortMain> createState() => _PortMainState();
}

class _PortMainState extends State<PortMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: [
        const SizedBox(width: 300, child: Port()),
        // 分割线
        Container(width: 1, color: AppTheme.dividerColor),
        Expanded(
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: Routes.router,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                toolbarHeight: 40,
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
