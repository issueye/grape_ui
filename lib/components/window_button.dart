import 'package:go_grape_ui/router/index.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

// ignore: must_be_immutable
class WindowButton extends StatefulWidget {
  WindowButton({
    super.key,
    required this.icon,
    required this.onTap,
    this.width = 35,
    this.height = AppTheme.defaultWindowTitleHeight - 10,
    this.iconSize = 20,
    this.color,
    this.hoverColor,
    this.iconColor,
    this.hoverIconColor,
    this.tips,
    this.backgroundColor = AppTheme.mainColor,
  });
  final IconData icon;
  final Function() onTap;
  double width;
  double height;
  double iconSize;
  Color? color;
  Color? backgroundColor;
  Color? iconColor;
  Color? hoverColor;
  Color? hoverIconColor;
  String? tips;

  @override
  State<WindowButton> createState() => _WindowButtonState();
}

class _WindowButtonState extends State<WindowButton> {
  Color? backgroundColor;
  Color? iconColor;
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    backgroundColor = widget.color;
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
      ),
      child: InkWell(
        onTap: widget.onTap,
        child: Tooltip(
          message: widget.tips ?? '',
          textStyle: AppTheme.lightTextStyle,
          child: Container(
            decoration: BoxDecoration(
              color: isHover ? widget.hoverColor : widget.color,
              borderRadius: BorderRadius.circular(2),
            ),
            width: widget.width,
            height: widget.height,
            child: Icon(
              widget.icon,
              size: widget.iconSize,
              color: isHover ? widget.hoverIconColor : widget.iconColor,
            ),
          ),
        ),
        onHover: (value) {
          isHover = value;
          setState(() {});
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class LogoutButton extends StatefulWidget {
  const LogoutButton({super.key});

  @override
  State<LogoutButton> createState() => _LogoutButtonState();
}

class _LogoutButtonState extends State<LogoutButton> {
  @override
  Widget build(BuildContext context) {
    return WindowButton(
      icon: Icons.logout_outlined,
      iconColor: Colors.white,
      color: AppTheme.mainColor,
      hoverColor: const Color.fromARGB(183, 90, 144, 188),
      hoverIconColor: Colors.white,
      tips: '退出登录',
      onTap: () async {
        await windowManager.setSize(const Size(800, 500));
        await windowManager.center();
        // ignore: use_build_context_synchronously
        GoRouter.of(context).pushNamed(AppRoutes.loginNamed);
      },
    );
  }
}

// ignore: must_be_immutable
class MinButton extends StatefulWidget {
  const MinButton({super.key});

  @override
  State<MinButton> createState() => _MinButtonState();
}

class _MinButtonState extends State<MinButton> {
  @override
  Widget build(BuildContext context) {
    return WindowButton(
      icon: Icons.horizontal_rule_outlined,
      iconColor: Colors.white,
      color: AppTheme.mainColor,
      hoverColor: const Color.fromARGB(183, 90, 144, 188),
      hoverIconColor: Colors.white,
      tips: '最小化',
      onTap: () async {
        await windowManager.minimize();
      },
    );
  }
}

// ignore: must_be_immutable
class MaxButton extends StatefulWidget {
  const MaxButton({super.key});

  @override
  State<MaxButton> createState() => _MaxButtonState();
}

class _MaxButtonState extends State<MaxButton> {
  @override
  Widget build(BuildContext context) {
    return WindowButton(
      icon: Icons.check_box_outline_blank_outlined,
      iconColor: Colors.white,
      color: AppTheme.mainColor,
      hoverColor: const Color.fromARGB(183, 90, 144, 188),
      hoverIconColor: Colors.white,
      iconSize: 15,
      tips: '恢复或最大化',
      onTap: () async {
        bool isMax = await windowManager.isMaximized();
        bool isFullScreen = await windowManager.isFullScreen();
        if (isMax || isFullScreen) {
          await windowManager.unmaximize();
        } else {
          await windowManager.maximize();
        }
      },
    );
  }
}

// ignore: must_be_immutable
class ExitButton extends StatefulWidget {
  const ExitButton({super.key});

  @override
  State<ExitButton> createState() => _ExitButtonState();
}

class _ExitButtonState extends State<ExitButton> {
  @override
  Widget build(BuildContext context) {
    return WindowButton(
      icon: Icons.close_outlined,
      iconColor: Colors.white,
      color: AppTheme.mainColor,
      tips: '退出程序',
      onTap: () async {
        await windowManager.close();
      },
      hoverColor: AppTheme.dangerColor,
      hoverIconColor: Colors.white,
    );
  }
}

class Exit2Button extends StatefulWidget {
  const Exit2Button({super.key});

  @override
  State<Exit2Button> createState() => _Exit2ButtonState();
}

class _Exit2ButtonState extends State<Exit2Button> {
  @override
  Widget build(BuildContext context) {
    return WindowButton(
      icon: Icons.close_outlined,
      iconColor: Colors.black54,
      color: Colors.grey.shade100,
      backgroundColor: Colors.grey.shade100,
      tips: '退出程序',
      onTap: () async {
        await windowManager.close();
      },
      hoverColor: AppTheme.dangerColor,
      hoverIconColor: Colors.white,
    );
  }
}
