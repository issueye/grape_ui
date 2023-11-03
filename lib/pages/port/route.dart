import 'package:go_grape_ui/pages/port/main.dart';
import 'package:go_grape_ui/pages/port/node/dialog.dart';
import 'package:go_grape_ui/pages/port/rule/dialog.dart';
import 'package:go_router/go_router.dart';

class RulePageParam{
  int port;
  String title;

  RulePageParam(this.port, this.title);
}

class Routes {
  static const String mainPath = '/port/main';
  static const String rulePath = '/port/ruleForm'; // 匹配规则
  static const String nodePath = '/port/nodeForm'; // 节点管理

  static const String mainNamed = 'main';
  static const String ruleFormNamed = 'ruleForm';
  static const String nodeFormNamed = 'nodeForm';
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
        var p = state.extra as RulePageParam;
        return RuleDialog(
          port: p.port,
          title: p.title,
        );
      },
    ),
    GoRoute(
      name: nodeFormNamed,
      path: nodePath,
      builder: (context, state) {
        var title = state.extra as String;
        return NodeDialog(title: title);
      },
    ),
  ]);
}
