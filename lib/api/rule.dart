import 'package:go_grape_ui/model/rule/rule_info.dart';
import '../components/custom_toast.dart';
import '../model/res_message.dart';
import '../model/rule/datum.dart';
import '../utils/request/services.dart';

class RuleApi {
  // 创建匹配规则
  static Future<ResMessage> create(Datum data) async {
    String url = '/api/v1/rule';
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

  // 获取匹配规则列表
  static Future<Rule> getList({Map<String, dynamic>? params}) async {
    String url = '/api/v1/rule';
    var res = await DioSingleton.getData(url, params: params);
    var resData = Rule.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 删除匹配规则信息
  static Future<ResMessage> delete(String id) async {
    String url = '/api/v1/rule/$id';
    var res = await DioSingleton.deleteData(url);
    var resData = ResMessage.fromJson(res.data);

    if (resData.code != 200) {
      Toast.Error(resData.message!);
    } else {
      Toast.Success(resData.message!);
    }

    return resData;
  }

  // 修改匹配规则信息
  static Future<ResMessage> modify(Datum data) async {
    String url = '/api/v1/rule';
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
