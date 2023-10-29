import 'package:flutter/material.dart';
import 'package:go_grape_ui/pages/port/node_mana.dart';

import '../../utils/app_theme.dart';
import 'port_mana.dart';

class PortMana extends StatefulWidget {
  const PortMana({super.key});

  @override
  State<PortMana> createState() => _PortManaState();
}

class _PortManaState extends State<PortMana> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 300,
          child: Port(),
        ),
        // 分割线
        Container(
          width: 1,
          color: AppTheme.dividerColor,
        ),
        const Expanded(
          child: NodeMana(),
        ),
      ],
    );
  }
}
