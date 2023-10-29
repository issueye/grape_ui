import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../utils/app_theme.dart';
import 'bar_button.dart';
import 'custom_button.dart';
import 'custom_divider.dart';
import 'default_button.dart';

class MessageBox extends StatefulWidget {
  const MessageBox({
    super.key,
    required this.tag,
    required this.title,
    this.width = 300,
    this.height = 180,
    required this.message,
  });
  final String tag;
  final String title;
  final String message;
  final double width;
  final double height;

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(width: 10),
                Text(widget.title, style: AppTheme.sizeTextStyle(16)),
                const Spacer(),
                BarButton(
                    icon: Resources.cancel,
                    onTap: () async {
                      await SmartDialog.dismiss(tag: widget.tag, result: false);
                      return false;
                    }),
                const SizedBox(width: 10),
              ],
            ),
          ),
          const CustomDivider(),
          const SizedBox(height: 30),
          Row(
            children: [
              const Spacer(),
              Text(widget.message, style: AppTheme.defaultTextStyle),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              const Spacer(),
              PlainButton(
                name: '取消',
                onPressed: () async {
                  await SmartDialog.dismiss(tag: widget.tag, result: false);
                  return false;
                },
              ),
              const SizedBox(width: 10),
              CustomButton(
                  name: '确定',
                  onPressed: () async {
                    await SmartDialog.dismiss(tag: widget.tag, result: true);
                    return true;
                  }),
              const SizedBox(width: 10),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

Future<bool> showMessageBox(String title, String message) async {
  var result = await SmartDialog.show<bool>(
    clickMaskDismiss: false,
    tag: 'delete_data',
    builder: (context) {
      return MessageBox(
        tag: 'delete_data',
        title: title,
        message: message,
      );
    },
  );

  return result as bool;
}
