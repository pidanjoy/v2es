import 'dart:io';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/util/file_util.dart';

class ReqClient {
  static const bool proxyEnable = true;
  static const proxyHost = '192.168.3.141';
  static const proxyPort = 1082;

  static const int _connectTimeout = 30000;
  static const int _receiveTimeout = 30000;

  static final ReqClient _instance = ReqClient._internal();

  factory ReqClient({ReqClientOptions? options}) => _instance;

  Dio? dio;

  ReqClient._internal({ReqClientOptions? options}) {
    if (null == dio) {
      BaseOptions options = BaseOptions(
        connectTimeout: const Duration(seconds: _connectTimeout),
        receiveTimeout: const Duration(seconds: _receiveTimeout),
        headers: {},
      );

      dio = Dio(options);
      dio!.interceptors.add(ErrorInterceptor());

      if (proxyEnable) {
        dio!.httpClientAdapter = IOHttpClientAdapter()
          ..createHttpClient = () => HttpClient()
            ..findProxy = (uri) {
              return "PROXY $proxyHost:$proxyPort;";
            }
            ..badCertificateCallback =
                (X509Certificate cert, String host, int port) => true;
      }
    }
    if (null != options) {
      if (null != options.baseUrl) {
        dio!.options.baseUrl = options.baseUrl!;
      }
      if (null != options.connectTimeout) {
        dio!.options.connectTimeout =
            Duration(seconds: options.connectTimeout!);
      }
      if (null != options.receiveTimeout) {
        dio!.options.receiveTimeout =
            Duration(seconds: options.receiveTimeout!);
      }
      if (null != options.headers) {
        dio!.options.headers = options.headers;
      }
      if (null != options.interceptors && options.interceptors!.isNotEmpty) {
        dio!.interceptors.addAll(options.interceptors!);
      }
    }
  }

  void setHeaders(Map<String, dynamic> map) {
    dio!.options.headers = map;
  }

  Future get(
    String path, {
    Map<String, dynamic>? params,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    Response response = await dio!.get(
      path,
      queryParameters: params,
      options: requestOptions,
    );
    return response;
  }

  Future post(
    String path, {
    Map<String, dynamic>? queryParams,
    dynamic data,
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio!.post(
      path,
      data: data,
      queryParameters: queryParams,
      options: requestOptions,
    );
    return response;
  }

  Future postForm(
    String path,
    Map<String, dynamic> params, {
    Options? options,
  }) async {
    Options requestOptions = options ?? Options();
    var response = await dio!.post(
      path,
      data: FormData.fromMap(params),
      options: requestOptions,
    );
    return response;
  }

  Future<Uint8List?> loadImage(
    String path, Map<String, dynamic>? params) async {
    File file = await FileUtil.getCacheFile(CommonUtil.getTextIdent(path));
    if (await file.exists()) {
      return file.readAsBytes();
    }

    var response = await dio!.get(path,
        options: Options(
          responseType: ResponseType.stream,
        ));
    final stream = await (response.data as ResponseBody).stream.toList();
    final result = BytesBuilder();
    for (Uint8List subList in stream) {
      result.add(subList);
    }
    var bytes = result.takeBytes();
    file.writeAsBytesSync(bytes);
    return bytes;
  }
}

class ReqClientOptions {
  String? baseUrl;
  int? connectTimeout;
  int? receiveTimeout;
  Map<String, dynamic>? headers;
  List<Interceptor>? interceptors;
}

class AppException implements Exception {
  final String _message;
  final int _code;

  AppException(
    this._code,
    this._message,
  );

  @override
  String toString() {
    return "$_code$_message";
  }

  factory AppException.create(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return BadRequestException(-1, "请求取消");
      case DioExceptionType.connectionTimeout:
        return BadRequestException(-1, "连接超时");
      case DioExceptionType.sendTimeout:
        return BadRequestException(-1, "请求超时");
      case DioExceptionType.receiveTimeout:
        return BadRequestException(-1, "响应超时");
      case DioExceptionType.badResponse:
        try {
          int errCode = error.response?.statusCode ?? -1;
          switch (errCode) {
            case 302:
              return UnauthorisedException(errCode, "请求被重定向");
            case 401:
              return UnauthorisedException(errCode, "没有访问权限");
            case 500:
              return UnauthorisedException(errCode, "服务器内部错误");
            default:
              {
                return AppException(
                    errCode, error.response?.statusMessage ?? "未知错误：$errCode");
              }
          }
        } on Exception catch (_) {
          return AppException(-1, "未知服务器异常");
        }
      default:
        return AppException(-1, error.message ?? "未知请求错误");
    }
  }
}

class BadRequestException extends AppException {
  BadRequestException(int? code, String? message)
      : super(code ?? -1, message ?? "请求发生错误");
}

class UnauthorisedException extends AppException {
  UnauthorisedException(int? code, String? message)
      : super(code ?? -1, message ?? "服务器发生异常");
}

class ErrorInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    debugPrint(
        "\n===DioRequest Start===\n>> DioRequest: ${options.path}\n===DioRequest End===\n");
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) {
    // debugPrint(
    // "\n===DioResponse Start===\n<< DioResponse: ${response.data.toString()}\n===DioResponse End===\n");
    super.onResponse(response, handler);
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) {
    AppException appException = AppException.create(err);
    debugPrint(
        '\n===DioException Start===\nxx DioException: ${appException.toString()}\n===DioException End===\n');
    super.onError(err, handler);
  }
}
