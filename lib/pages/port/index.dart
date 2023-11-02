import 'package:flutter/material.dart';

import 'route.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 40,
        ),
      ),
      routerConfig: Routes.router,
    );
  }
}
