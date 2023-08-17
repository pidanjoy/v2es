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

  static Future post(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic data,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await ReqClient().post(
      path,
      data: data,
      queryParams: queryParams,
      options: requestOptions,
    );
    return response.data;
  }

  static Future postForm(
    String path,
    Map<String, dynamic> params, {
    Options? options,
  }) async {
    return await ReqClient().postForm(
      path,
      params,
      options: options,
    );
  }
}
