import 'package:flutter/material.dart';
import 'package:go_grape_ui/model/cert/cert.dart';

import '../model/cert/datum.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

class CertApi {
  // 创建目标地址信息
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/cert';
    var reqData = data.toJson();
    debugPrint('reqData = $reqData');
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 获取目标地址列表
  static Future<Cert> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/cert';
    var res = await DioSingleton.getData(url, params: params);
    return Cert.fromJson(res.data);
  }

  // 删除目标地址信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/cert/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改目标地址信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/cert';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }
}
