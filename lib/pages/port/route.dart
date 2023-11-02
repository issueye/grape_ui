import 'package:go_grape_ui/pages/port/main.dart';
import 'package:go_grape_ui/pages/port/rule/dialog.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String mainPath = '/port/main';
  static const String rulePath = '/port/ruleForm'; // 匹配规则

  static const String mainNamed = 'main';
  static const String ruleFormNamed = 'ruleForm';
  static GoRouter router = GoRouter(initialLocation: mainPath, routes: [
    GoRoute(
      name: mainNamed,
      path: mainPath,
      builder: (context, state) {
        return const PortMain();
      },
    ),
    GoRoute(
      name: ruleFormNamed,
      path: rulePath,
      builder: (context, state) {
        return RuleDialog(
          tag: '',
          title: '添加匹配规则',
        );
      },
    ),
  ]);
}
