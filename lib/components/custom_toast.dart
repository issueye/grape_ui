import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_grape_ui/utils/app_theme.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(this.msg,
      {Key? key, required this.color, required this.icon})
      : super(key: key);
  final String msg;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.only(bottom: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        decoration: BoxDecoration(
          color: color.withOpacity(.7),
          borderRadius: AppTheme.defaultRadius,
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          //icon
          Container(
            margin: const EdgeInsets.only(right: 15),
            child: Icon(icon, color: color),
          ),
          //msg
          Text(msg, style: AppTheme.lightTextStyle),
        ]),
      ),
    );
  }
}

class Toast {
  // ignore: non_constant_identifier_names
  static void Info(String msg) {
    SmartDialog.showToast(
      '',
      builder: (_) =>
          CustomToast(msg, icon: Icons.info, color: AppTheme.hintColor),
    );
  }

  // ignore: non_constant_identifier_names
  static void Error(String msg) {
    SmartDialog.showToast(
      '',
      builder: (_) =>
          CustomToast(msg, icon: Icons.error, color: AppTheme.dangerColor),
    );
  }

  // ignore: non_constant_identifier_names
  static void Warn(String msg) {
    SmartDialog.showToast(
      '',
      builder: (_) =>
          CustomToast(msg, icon: Icons.warning, color: AppTheme.warnColor),
    );
  }

  // ignore: non_constant_identifier_names
  static void Primary(String msg) {
    SmartDialog.showToast(
      '',
      builder: (_) =>
          CustomToast(msg, icon: Icons.info_sharp, color: AppTheme.mainColor),
    );
  }

  // ignore: non_constant_identifier_names
  static void Success(String msg) {
    SmartDialog.showToast(
      '',
      builder: (_) =>
          CustomToast(msg, icon: Icons.done, color: AppTheme.successColor),
    );
  }
}
