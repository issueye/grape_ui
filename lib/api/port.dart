import 'package:go_grape_ui/model/port/datum.dart';
import 'package:go_grape_ui/model/port/port_list.dart';
import '../components/custom_toast.dart';
import '../model/res_message.dart';
import '../utils/request/services.dart';

// 端口号管理
class PortApi {
  // 创建端口号信息
  static Future<ResMessage> createPort(Datum data) async {
    String url = '/api/v1/port';
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

  // 查询端口号信息列表
  static Future<PortList> list(Map<String, dynamic>? params) async {
    String url = '/api/v1/port';
    var res = await DioSingleton.getData(url, params: params);
    var resData = PortList.fromJson(res.data);
    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 删除端口号
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/port/$id';
    var res = await DioSingleton.deleteData(url);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 修改信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/port';
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

  // 修改状态
  static Future<ResMessage> modifyState(String id) async {
    String url = '/api/v1/port/state/$id';
    var res = await DioSingleton.putData(url, null);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 重启
  static Future<ResMessage> reload(String id) async {
    String url = '/api/v1/port/reload/$id';
    var res = await DioSingleton.putData(url, null);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }
}
