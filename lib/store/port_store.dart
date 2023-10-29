import 'package:flutter/material.dart';
import 'package:go_grape_ui/api/api.dart';
import 'package:go_grape_ui/api/port.dart';
import 'package:go_grape_ui/model/port_list/datum.dart';
import 'package:go_grape_ui/pages/port/port_mana.dart';
import '../model/add_repo.dart';
import '../model/port_list/port_list.dart';
import '../utils/request/services.dart';

class PortStore extends ChangeNotifier {
  PortList? _data;
  PortList? get data => _data; // 列表数据
  set data(PortList? data) {
    _data = data;
    notifyListeners();
  }

  // 创建数据
  Datum? createData;
  Datum? modifyData;

  // 当前选择
  int _selectIndex = 0;
  int get selectIndex => _selectIndex;
  set selectIndex(int index) {
    _selectIndex = index;
    notifyListeners();
  }

  PortStore();

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
  Future<void> createPort() async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.createPort(createData!);
  }

  // 获取列表
  Future<void> list() async {
    if (DioSingleton.baseUrl == '') return;
    var res = await PortApi.list(null);
    // listData = data;
    data = res;
  }

  // 修改信息
  Future<void> modify() async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.modify(modifyData!);
  }

  // 删除信息
  Future<void> delete(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.delete(id);
  }

  // 删除信息
  Future<void> modifyState(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.modifyState(id);
  }
}
