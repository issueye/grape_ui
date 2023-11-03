import 'package:flutter/material.dart';
import 'package:go_grape_ui/api/target.dart';
import '../model/target/datum.dart';
import '../model/target/target_info.dart';
import '../utils/request/services.dart';

class TargetStore extends ChangeNotifier {
  Target? _data;
  Target? get data => _data; // 列表数据
  set data(Target? data) {
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

  TargetStore();

  String getIdByName(String name) {
    if (data == null) return '';
    if (name == '') return '';

    var list = data!.data!;

    if (list.isEmpty) return '';

    for (var i = 0; i < list.length; i++) {
      if (list[i].name == name) {
        return list[i].id!;
      } 
    }

    return '';
  }

  String getNameById(String id) {
    if (data == null) return '';
    if (id == '') return '';

    var list = data!.data!;

    if (list.isEmpty) return '';

    for (var i = 0; i < list.length; i++) {
      if (list[i].id == id) {
        return list[i].name!;
      } 
    }

    return '';
  }

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
    await TargetApi.create(createData);
  }

  // 获取列表
  Future<void> list({String? condition}) async {
    if (DioSingleton.baseUrl == '') return;
    var res = await TargetApi.getList(
      params: {'portId': _portId, 'condition': condition},
    );
    data = res;
  }

  // 修改信息
  Future<void> modify() async {
    if (DioSingleton.baseUrl == '') return;
    await TargetApi.modify(modifyData);
  }

  // 删除信息
  Future<void> delete(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await TargetApi.delete(id);
  }
}
