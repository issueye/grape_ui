import 'dart:convert';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/init/index.dart';
import 'package:go_grape_ui/init/windows.dart';
import 'package:go_grape_ui/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_grape_ui/store/cert_store.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:go_grape_ui/store/rule_store.dart';
import 'package:go_grape_ui/store/target_store.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  // 窗体初始化
  await init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PortStore>(create: (_) => PortStore()),
        ChangeNotifierProvider<NodeStore>(create: (_) => NodeStore()),
        ChangeNotifierProvider<RuleStore>(create: (_) => RuleStore()),
        ChangeNotifierProvider<TargetStore>(create: (_) => TargetStore()),
        ChangeNotifierProvider<CertStore>(create: (_) => CertStore()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme: const AppBarTheme(
            toolbarHeight: 40,
          ),
        ),
        routerConfig: AppRoutes.router,
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
