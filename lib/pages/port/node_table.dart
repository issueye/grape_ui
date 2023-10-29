import 'package:flutter/material.dart';

import '../../utils/app_theme.dart';

class FieldInfo {
  String name;
  double? width;

  FieldInfo({this.name = '', this.width});
}

// ignore: must_be_immutable
class NodeTable extends StatefulWidget {
  NodeTable({super.key, required this.fieldInfo});
  List<FieldInfo> fieldInfo;

  @override
  State<NodeTable> createState() => _NodeTableState();
}

class _NodeTableState extends State<NodeTable> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
          child: Row(
            children: _getHeader(),
          ),
        ),
      ],
    );
  }

  _getHeader() {
    List<Widget> header = [];
    for (var element in widget.fieldInfo) {
      header.add(
        _headerField(
          name: element.name,
          width: element.width,
        ),
      );
    }

    return header;
  }

  _headerField({
    String name = '',
    double? width,
    double height = 30,
  }) {
    var contain = Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(5),
      child: Text(
        name,
        style: AppTheme.defaultTextStyle,
      ),
    );

    return width == null ? Expanded(child: contain) : contain;
  }
}
