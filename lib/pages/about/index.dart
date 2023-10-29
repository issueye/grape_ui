import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  final TextStyle content = const TextStyle(
      color: Colors.grey,
      fontFamily: AppTheme.defaultFontFamily,
      fontSize: AppTheme.defaultFontSize);
  final TextStyle title = const TextStyle(
      color: AppTheme.mainColor,
      fontFamily: AppTheme.defaultFontFamily,
      fontSize: AppTheme.defaultFontSize);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(),
          Image.asset(
            'assets/images/logo.png',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          RichText(
            text: TextSpan(
              text: '',
              children: [
                TextSpan(text: '名称 :  ', style: title, children: [
                  TextSpan(text: 'golang 代理服务\n', style: content)
                ]),
                TextSpan(
                    text: '时间 :  ',
                    style: title,
                    children: [TextSpan(text: '2023-10-18\n', style: content)]),
                TextSpan(
                    text: '版本 :  ',
                    style: title,
                    children: [TextSpan(text: 'v0.0.1\n', style: content)]),
                TextSpan(text: '内容 :  \n\n', style: title, children: [
                  TextSpan(text: 'golang 代理服务\n', style: content)
                ]),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
