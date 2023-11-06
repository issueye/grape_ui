// 端口号管理
import 'package:go_grape_ui/model/node/node.dart';

import '../components/custom_toast.dart';
import '../model/node/datum.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

class NodeApi {
  // 创建节点信息
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    var res = await DioSingleton.postData(url, reqData);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 获取节点列表
  static Future<Node> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/node';
    var res = await DioSingleton.getData(url, params: params);
    var resData = Node.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 删除节点信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/node/$id';
    var res = await DioSingleton.deleteData(url);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 修改节点信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/node';
    var reqData = data.toJson();
    var res = await DioSingleton.putData(url, reqData);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 上传静态页面
  static Future<ResMessage> upload(String filepath, String filename,
      {Map<String, dynamic>? options}) async {
    String url = '/api/v1/node/upload';
    var res = await DioSingleton.uploadFile(url, filepath,
        filename: filename, options: options);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }
}
