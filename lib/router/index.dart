import 'package:go_grape_ui/pages/home/index.dart';
import 'package:go_grape_ui/pages/login/index.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String homePath = '/'; // 根路由
  static const String rulePath = '/ruleForm'; // 匹配规则
  static const String loginPath = '/login'; // 登录页面

  static const String homeNamed = 'home';
  static const String loginNamed = 'login';
  static GoRouter router = GoRouter(
    initialLocation: loginPath,
    routes: [
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
    ],
  );
}
