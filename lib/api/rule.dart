// 端口号管理
import 'package:flutter/material.dart';
import 'package:go_grape_ui/model/rule/rule_info.dart';

import '../model/res_message.dart';
import '../model/rule/datum.dart';
import '../utils/request/services.dart';

class RuleApi {
  // 创建匹配规则
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/rule';
    var reqData = data.toJson();
    debugPrint('reqData = $reqData');
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 获取匹配规则列表
  static Future<Rule> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/rule';
    var res = await DioSingleton.getData(url, params: params);
    return Rule.fromJson(res.data);
  }

  // 删除匹配规则信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/rule/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改匹配规则信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/rule';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }
}