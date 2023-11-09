import 'package:flutter/material.dart';
import 'package:go_grape_ui/api/port.dart';
import 'package:go_grape_ui/model/port/datum.dart';
import '../model/port/port_list.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

class PortStore extends ChangeNotifier {
  PortList? _data;
  PortList? get data => _data; // 列表数据
  set data(PortList? data) {
    _data = data;
    notifyListeners();
  }

  // 创建数据
  Datum createData = Datum();
  Datum modifyData = Datum();
  // 当前选择的数据
  Datum selectData = Datum();

  // 状态
  int operationType = 0;

  // 当前选择
  int _selectIndex = -1;
  int get selectIndex => _selectIndex;
  set selectIndex(int index) {
    _selectIndex = index;
    selectData = data!.data![index];
    notifyListeners();
  }

  int port = 0;

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
  Future<void> create() async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.createPort(createData);
  }

  // 获取列表
  Future<void> list() async {
    if (DioSingleton.baseUrl == '') return;
    var res = await PortApi.list(null);
    data = res;
  }

  // 修改信息
  Future<void> modify() async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.modify(modifyData);
  }

  // 删除信息
  Future<void> delete(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.delete(id);
  }

  // 修改状态
  Future<void> modifyState(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.modifyState(id);
  }

  // 重启
  Future<void> reload(String id) async {
    if (DioSingleton.baseUrl == '') return;
    await PortApi.reload(id);
  }

  // 关闭端口监听
  Future<ResMessage?> stop(String id) async {
    if (DioSingleton.baseUrl == '') return null;
    return await PortApi.stop(id);
  }

  // 开启端口监听
  Future<ResMessage?> start(String id) async {
    if (DioSingleton.baseUrl == '') return null;
    return await PortApi.start(id);
  }
}
