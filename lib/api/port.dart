import 'package:go_grape_ui/model/port_list/datum.dart';
import 'package:go_grape_ui/model/port_list/port_list.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

// 端口号管理
class PortApi {
  // 创建端口号信息
  static Future<ResMessage> createPort(Datum data) async {
    String url = '/api/v1/port';
    var reqData = data.toJson();
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 查询端口号信息列表
  static Future<PortList> list(Map<String, dynamic>? params) async {
    String url = '/api/v1/port';
    var res = await DioSingleton.getData(url, params: params);
    return PortList.fromJson(res.data);
  }

  // 删除端口号
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/port/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }

  // 修改信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/port';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 修改状态
  static Future<ResMessage> modifyState(String id) async {
    String url = '/api/v1/port/state/$id';
    var res = await DioSingleton.putData(url, null);
    return ResMessage.fromJson(res.data);
  }
}
