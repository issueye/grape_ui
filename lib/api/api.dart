import 'package:go_grape_ui/model/add_repo.dart';
import 'package:go_grape_ui/model/res_message.dart';

import '../model/repo_list/repo_list.dart';
import '../model/version_info/version_info.dart';
import '../utils/request/services.dart';

class Api {
  // 获取项目列表
  static Future<RepoList> getRepoList() async {
    const String url = '/admin/api/v1/repo';
    var res = await DioSingleton.getData(url);
    // debugPrint('${data.data}');
    return RepoList.fromMap(res.data);
  }

  // 获取版本列表
  static Future<VersionInfo> getVersionInfoList(
      Map<String, dynamic>? params) async {
    const String url = '/admin/api/v1/repo/version';
    var res = await DioSingleton.getData(url, params: params);
    return VersionInfo.fromMap(res.data);
  }

  // 添加项目
  static Future<ResMessage> addRepo(AddRepo data) async {
    const String url = '/admin/api/v1/repo';
    var reqData = data.toJson();
    var res = await DioSingleton.postData(url, reqData);
    return ResMessage.fromJson(res.data);
  }

  // 添加项目
  static Future<ResMessage> deleteRepo(String id) async {
    String url = '/admin/api/v1/repo/$id';
    var res = await DioSingleton.deleteData(url);
    return ResMessage.fromJson(res.data);
  }
}
