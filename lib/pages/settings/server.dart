import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_button.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/components/custom_form_text_field.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:go_grape_ui/utils/db/config.dart';
import 'package:go_grape_ui/utils/request/services.dart';

class ServerSettingsPage extends StatefulWidget {
  const ServerSettingsPage({super.key});

  @override
  State<ServerSettingsPage> createState() => _ServerSettingsPageState();
}

class _ServerSettingsPageState extends State<ServerSettingsPage> {
  final TextEditingController _serverHostController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initConfig();
  }

  Future<void> _initConfig() async {
    var serverHost = await ConfigDB.getStr('server_host');
    _serverHostController.text = serverHost;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: CustomDivider(),
            ),
            SizedBox(width: 10),
            Text('服务信息', style: AppTheme.defaultTextStyle),
            SizedBox(width: 10),
            Expanded(
              child: CustomDivider(),
            ),
          ],
        ),
        const SizedBox(height: 30),
        Row(
          children: [
            const SizedBox(width: 50),
            SizedBox(
              width: 500,
              child: CustomFormTextField(
                controller: _serverHostController,
                title: '服务地址',
                hintText: '请输入服务地址',
                titleWidth: 65,
                isHaveTo: true,
              ),
            ),
          ],
        ),
        Row(
          children: [
            const SizedBox(width: 130),
            CustomButton(
              name: '确定',
              onPressed: () async {
                await ConfigDB.setStr(
                    'server_host', _serverHostController.text);
                var serverHost = await ConfigDB.getStr('server_host');
                debugPrint(serverHost);
                // 设置 dio 的baseUrl
                DioSingleton.baseUrl = serverHost;
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}
