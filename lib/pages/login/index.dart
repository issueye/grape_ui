import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/components/window_button.dart';
import 'package:go_grape_ui/router/index.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:window_manager/window_manager.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _account = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final double _fieldWidth = 300;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          InkWell(
            child: Image.asset(
              'assets/images/_login.jpg',
              width: 380,
              fit: BoxFit.fill,
            ),
            onTapDown: (details) async {
              await windowManager.startDragging();
            },
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
            ),
            width: 400,
            child: Column(
              children: [
                InkWell(
                  child: SizedBox(
                    width: 400,
                    height: AppTheme.defaultAppBarHeight,
                    child: Row(
                      children: const [
                        Spacer(),
                        Exit2Button(),
                      ],
                    ),
                  ),
                  onTapDown: (details) async {
                    await windowManager.startDragging();
                  },
                ),
                const SizedBox(height: 100),
                Text(
                  'golang 代理服务',
                  style: AppTheme.sizeTextStyle(28),
                ),
                const SizedBox(height: 30),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: _fieldWidth,
                              child: CustomFormTextField(
                                title: '账号',
                                controller: _account,
                                hintText: '请输入账号',
                                isHaveTo: true,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                        Row(
                          children: [
                            const Spacer(),
                            SizedBox(
                              width: _fieldWidth,
                              child: CustomFormTextField(
                                title: '密码',
                                controller: _password,
                                hintText: '请输入密码',
                                isHaveTo: true,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    )),
                const SizedBox(height: 30),
                CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await windowManager.setSize(const Size(1200, 800));
                        await windowManager.center();
                        // ignore: use_build_context_synchronously
                        GoRouter.of(context).pushNamed(AppRoutes.homeNamed);
                      }
                    },
                    name: '登录'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
