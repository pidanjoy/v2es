import 'package:dio/dio.dart';
import 'package:v2es/util/http_client.dart';

class HttpUtil {
  static void ins({ReqClientOptions? options}) {
    ReqClient(options: options);
  }

  static void setHeaders(Map<String, dynamic> map) {
    ReqClient().setHeaders(map);
  }

  static Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    return await ReqClient().get(
      path,
      params: params,
      options: options,
    );
  }
}
