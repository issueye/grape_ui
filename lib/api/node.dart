// 端口号管理
import 'package:flutter/material.dart';
import 'package:go_grape_ui/model/node/node.dart';

import '../model/node/datum.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

class NodeApi {
  // 创建节点信息
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    debugPrint('reqData = $reqData');
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 获取节点列表
  static Future<Node> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/node';
    var res = await DioSingleton.getData(url, params: params);
    return Node.fromJson(res.data);
  }

  // 删除节点信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/node/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改节点信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }
}