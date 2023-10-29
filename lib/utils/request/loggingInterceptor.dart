import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final Logger logger = Logger('dio->request');
    logger.info('''

-------------------------- 请求 --------------------------
*请求方法* ${options.method}
*请求地址* ${options.uri}
*请求头部* ${options.headers}
*请求数据* ${options.data}
----------------------------------------------------------
''');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // logger.info('Response: ${response.statusCode} ${response.requestOptions.uri}');
    // logger.info('Headers: ${response.headers}');
    // logger.info('Data: ${response.data}');
    final Logger logger = Logger('dio-response');
    logger.info('''

-------------------------- 返回 --------------------------
*返回状态* ${response.statusCode}
*请求地址* ${response.requestOptions.uri}
----------------------------------------------------------
''');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    final Logger logger = Logger('dio-error');
    logger.severe('Error: ${err.message} ${err.requestOptions.uri}');
    super.onError(err, handler);
  }
}