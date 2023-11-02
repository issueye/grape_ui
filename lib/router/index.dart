import 'package:go_grape_ui/pages/home/index.dart';
import 'package:go_grape_ui/pages/login/index.dart';
import 'package:go_grape_ui/pages/rule/dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/custom_select.dart';
import '../store/port_store.dart';

class AppRoutes {
  static const String homePath = '/'; // 根路由
  static const String rulePath = '/ruleForm'; // 匹配规则
  static const String loginPath = '/login'; // 登录页面

  static const String homeNamed = 'home';
  static const String loginNamed = 'login';
  static const String ruleFormNamed = 'ruleForm';
  static GoRouter router = GoRouter(initialLocation: loginPath, routes: [
    GoRoute(
      name: loginNamed,
      path: loginPath,
      builder: (context, state) {
        return const LoginPage();
      },
    ),
    GoRoute(
      name: homeNamed,
      path: homePath,
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      name: ruleFormNamed,
      path: rulePath,
      builder: (context, state) {
        var port = Provider.of<PortStore>(context);
      List<SelectOption> list = [];
      for (var element in port.data!.data!) {
        list.add(SelectOption(element.id!, element.port.toString()));
      }
        return RuleDialog(list: list, tag: '', title: '添加匹配规则',);
      },
    ),
  ]);
}
