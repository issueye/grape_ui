import 'package:flutter/material.dart';
import 'package:go_grape_ui/components/custom_divider.dart';
import 'package:go_grape_ui/model/node/node.dart';
import 'package:go_grape_ui/store/node_store.dart';
import 'package:provider/provider.dart';
import '../../utils/app_theme.dart';

typedef FieldChild = Widget Function(BuildContext, int, dynamic);

class FieldInfo {
  String title;
  String name;
  double? width;
  bool clip;
  bool titleCenter;
  FieldChild? child;

  FieldInfo(
      {this.title = '',
      this.name = '',
      this.width,
      this.clip = false,
      this.child,
      this.titleCenter = false});
}

// ignore: must_be_immutable
class NodeTable extends StatefulWidget {
  NodeTable(
      {super.key,
      required this.fieldInfo,
      required this.context,
      this.tableData});
  List<FieldInfo> fieldInfo;
  Node? tableData;
  BuildContext context;

  @override
  State<NodeTable> createState() => _NodeTableState();
}

class _NodeTableState extends State<NodeTable> {
  List<Widget> rows = [];
  int selectRow = -1;

  @override
  Widget build(BuildContext context) {
    _getTableBody();

    return SizedBox(
      height: 450,
      child: Column(
        children: [
          Row(children: _getHeader()),
          const CustomDivider(space: 5),
          Expanded(
            child: Consumer<NodeStore>(
              builder: (context, value, child) {
                if (rows.isEmpty) {
                  return Expanded(
                    child: rows[0],
                  );
                }

                return ListView.builder(
                  itemCount: rows.length,
                  itemBuilder: (context, index) {
                    return rows[index];
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _getTableBody() {
    rows.clear();
    if (widget.tableData == null) {
      rows.add(const Center(child: Text('没有数据', style: AppTheme.defaultTextStyle)));
      return rows;
    }

    for (var i = 0; i < widget.tableData!.data!.length; i++) {
      var data = widget.tableData!.data![i].toJson();
      List<Widget> rowData = [];

      for (var element in widget.fieldInfo) {
        rowData.add(
          fieldData(
            name: data[element.name],
            width: element.width,
            clip: element.clip,
            index: i,
            child: element.child,
          ),
        );
      }

      var row = SizedBox(
        height: 40,
        child: Ink(
          color: i % 2 == 0 ? const Color(0xFFF0F7FF) : Colors.white,
          child: InkWell(
            onTap: () {
              setState(() {
                selectRow = i;
              });
            },
            hoverColor: const Color(0xffD6EAFF),
            child: Container(
              color: selectRow == i ? const Color(0xffA6D1FF) : null,
              child: Row(children: rowData),
            ),
          ),
        ),
      );
      rows.add(row);
    }
  }

  List<Widget> _getHeader() {
    List<Widget> header = [];
    for (var element in widget.fieldInfo) {
      header.add(
        fieldData(
            name: element.title,
            width: element.width,
            isCenter: element.titleCenter),
      );
    }
    return header;
  }

  fieldData({
    dynamic name = '',
    double? width,
    double size = 12,
    bool clip = false,
    bool isCenter = false,
    FieldChild? child,
    int index = -1,
  }) {
    var text = Text('$name',
        overflow: TextOverflow.ellipsis, style: AppTheme.sizeTextStyle(size));

    var contain = Container(
      width: width,
      padding: const EdgeInsets.all(5),
      alignment: isCenter ? Alignment.center : null,
      child: clip
          ? Tooltip(
              message: name.toString(),
              textStyle: AppTheme.lightTextStyle,
              child: text,
            )
          : child == null
              ? text
              : child(widget.context, index, name),
    );

    return width == null ? Expanded(child: contain) : contain;
  }
}
