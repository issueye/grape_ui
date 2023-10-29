import 'package:go_grape_ui/components/window_button.dart';
import 'package:go_grape_ui/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:window_manager/window_manager.dart';

import '../../components/custom_vertical_divider.dart';

class WinTitle extends StatefulWidget {
  const WinTitle({super.key});

  @override
  State<WinTitle> createState() => _WinTitleState();
}

class _WinTitleState extends State<WinTitle> {
  @override
  Widget build(BuildContext context) {
    Logger log = Logger('home-> index');

    return Row(
      children: [
        Expanded(
          child: InkWell(
            child: Container(
              height: AppTheme.defaultAppBarHeight,
              color: AppTheme.mainColor,
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(66, 255, 255, 255),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    onTap: () {
                      debugPrint('click');
                    },
                  ),
                  Container(),
                ],
              ),
            ),
            onTapDown: (details) {
              // log.info('鼠标长按  $details');
              log.info('鼠标点击');
              windowManager.startDragging();
            },
            onDoubleTap: () async {
              log.info('双击');
              final isMax = await windowManager.isMaximized();
              final isFullScreen = await windowManager.isFullScreen();

              if (isMax || isFullScreen) {
                await windowManager.restore();
              } else {
                await windowManager.maximize();
              }
            },
          ),
        ),
        const LogoutButton(),
        const CustomVerticalDivider(color: AppTheme.dividerColor),
        const MinButton(),
        const MaxButton(),
        const ExitButton(),
      ],
    );
  }
}
