import 'package:flutter/material.dart';
import 'package:go_grape_ui/api/node.dart';
import '../model/node/datum.dart';
import '../model/node/node.dart';
import '../utils/request/services.dart';

class NodeStore extends ChangeNotifier {
  Node? _data;
  Node? get data => _data; // 列表数据
  set data(Node? data) {
    _data = data;
    notifyListeners();
  }

  String _portId = '';
  String get portId => _portId;
  set portId(String id) {
    _portId = id;
    list();
  } 


  // 创建数据
  Datum createData = Datum();
  Datum modifyData = Datum();

  // 状态
  int operationType = 0;

  // 当前选择
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  NodeStore();

  // 长度
  int len() {
    if (data == null) {
      return 0;
    } else {
      if (data!.data == null) {
        return 0;
      } else {
        return data!.data!.length;
      }
    }
  }

  // 添加端口号信息
  Future<void> create() async {
    if (DioSingleton.baseUrl == '') return;
    modifyData.portId = portId;
    await NodeApi.createNode(createData);
  }

  // 获取列表
  Future<void> list() async {
    if (DioSingleton.baseUrl == '') return;
    var res = await NodeApi.getList(params: {'portId': _portId});
    data = res;
  }

  // 修改信息
  Future<void> modify() async {
    if (DioSingleton.baseUrl == '') return;
    modifyData.portId = portId;
    await NodeApi.modify(modifyData);
  }

  // 删除信息
  Future<void> delete(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await NodeApi.delete(id);
  }
}
