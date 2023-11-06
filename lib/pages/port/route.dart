import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/port/main.dart';
import 'package:go_grape_ui/pages/port/node/dialog.dart';
import 'package:go_grape_ui/pages/port/port_main.dart';
import 'package:go_grape_ui/pages/port/rule/dialog.dart';
import 'package:go_router/go_router.dart';

class RulePageParam {
  int port;
  String title;

  RulePageParam(this.port, this.title);
}

class Routes {
  static const String indexPath = '/port'; // 主页面
  static const String mainPath = '/port/main';
  static const String rulePath = '/port/ruleForm'; // 匹配规则
  static const String nodePath = '/port/nodeForm'; // 节点管理

  static const String indexNamed = 'index';
  static const String mainNamed = 'main';
  static const String ruleFormNamed = 'ruleForm';
  static const String nodeFormNamed = 'nodeForm';
  static GoRouter router = GoRouter(initialLocation: indexPath, routes: [
    GoRoute(
      name: indexNamed,
      path: indexPath,
      builder: (context, state) {
        return const PortMainPage();
      },
    ),
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
      // 动画过度
      pageBuilder: (context, state) {
        var p = state.extra as RulePageParam;
        return CustomTransitionPage(
          key: state.pageKey,
          child: RuleDialog(port: p.port, title: p.title),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      name: nodeFormNamed,
      path: nodePath,
      pageBuilder: (context, state) {
        var title = state.extra as String;
        return CustomTransitionPage(
          key: state.pageKey,
          child: NodeDialog(title: title),
          transitionDuration: const Duration(milliseconds: 500),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ]);
}
