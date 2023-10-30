// 端口号管理
import 'package:go_grape_ui/model/node/node.dart';

import '../model/node/datum.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

class NodeApi {
  // 创建节点信息
  static Future<ResMessage> createNode(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 获取节点列表
  static Future<Node> getList() async {
    String url = '/api/v1/node';
    var res = await DioSingleton.getData(url);
    return Node.fromJson(res.data);
  }

  // 删除端口号
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/node/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }
}