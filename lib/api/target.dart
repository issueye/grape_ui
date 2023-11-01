import 'package:flutter/material.dart';
import 'package:go_grape_ui/model/target/target_info.dart';

import '../model/res_message.dart';
import '../model/target/datum.dart';
import '../utils/request/services.dart';

class TargetApi {
  // 创建目标地址信息
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/target';
    var reqData = data.toJson();
    debugPrint('reqData = $reqData');
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 获取目标地址列表
  static Future<Target> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/target';
    var res = await DioSingleton.getData(url, params: params);
    return Target.fromJson(res.data);
  }

  // 删除目标地址信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/target/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改目标地址信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/target';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }
}
