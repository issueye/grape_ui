import 'package:dio/dio.dart';
import 'package:go_grape_ui/model/res_message.dart';

import '../../components/custom_toast.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 在请求发送之前的处理
    // 可以在此处添加请求头、记录日志等操作

    // 如果能够从缓存中获取到 token 则添加到请求头中
    // var token = await TokenManager.getToken();
    // if (token != '') {
    //   options.headers['Authorization'] = token;
    // }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 在收到响应后的处理
    // 可以在此处处理响应数据、错误状态码等
    var res = ResMessage.fromJson(response.data);
    if (res.code != 200) {
      Toast.Error(res.message!);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // 在请求发生错误时的处理
    // 可以在此处处理错误信息、错误状态码等

    super.onError(err, handler);
  }
}
