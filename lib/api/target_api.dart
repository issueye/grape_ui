import 'package:go_grape_ui/model/target/target_info.dart';
import '../components/custom_toast.dart';
import '../model/res_message.dart';
import '../model/target/datum.dart';
import '../utils/request/services.dart';

class TargetApi {
  // 创建目标地址信息
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/target';
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

  // 获取目标地址列表
  static Future<Target> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/target';
    var res = await DioSingleton.getData(url, params: params);
    var resData = Target.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 删除目标地址信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/target/$id';
    var res = await DioSingleton.deleteData(url);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 修改目标地址信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/target';
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
}
