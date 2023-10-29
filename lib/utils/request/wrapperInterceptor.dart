import 'package:dio/dio.dart';
// import 'package:version_management/common/message/message.dart';

class WrapperInterceptor extends Interceptor {
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // 在收到响应后的处理
    // 可以在此处处理响应数据、错误状态码等

    // Logger logger = Logger('response');
    // logger.info('data=${response.data['code']}');
    // if (response.data['code'] != 200) {
    //   Message.error(response.data['message']);
    // }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // 在请求发生错误时的处理
    // 可以在此处处理错误信息、错误状态码等

    // 错误消息
    // Message.error(err.message!);
    return;
    // super.onError(err, handler);
  }
}
