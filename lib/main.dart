import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/init/index.dart';
import 'package:go_grape_ui/router/index.dart';
import 'package:flutter/material.dart';
import 'package:go_grape_ui/store/port_store.dart';
import 'package:provider/provider.dart';

void main() async {
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
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: AppRoutes.router,
        builder: FlutterSmartDialog.init(),
      ),
    );
  }
}
