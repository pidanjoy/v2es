import 'package:flutter/cupertino.dart';
import 'package:v2es/api/login_api.dart';
import 'package:v2es/model/login_model.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/util/http_util.dart';

class LoginService {
  static LoginKey? _loginKey;
  static Map<String, Object> _headers = {};

  static Future<LoginKey?> getLoginKey() async {
    LoginKey? loginKey;
    try {
      loginKey = await LoginApi.getLoginKey();
    } catch (e) {
      debugPrint("LoginService.getLoginKey.error:$e");
      CommonUtil.showToast("请求登录参数失败");
    }
    if (loginKey != null) {
      _loginKey = loginKey;
      _setHttpClientCookie(loginKey.cookie);
    }
    return loginKey;
  }

  static Future<String?> getCookie(
      String username, String password, String captcha) async {
    if (_loginKey == null) {
      return null;
    }
    LoginParams loginParams = LoginParams(
        _loginKey!.username,
        username,
        _loginKey!.password,
        password,
        _loginKey!.captcha,
        captcha,
        _loginKey!.once,
        _loginKey!.next);

    String? setCookie;
    try {
      setCookie = await LoginApi.loginPickCookie(loginParams, _headers);
    } catch (e) {
      debugPrint("LoginService.getCookie.error:$e");
    }
    if (setCookie != null) {
      _setHttpClientCookie(setCookie);
    } else {
      CommonUtil.showToast("请求登录失败");
    }
    return setCookie;
  }

  static void _setHttpClientCookie(String cookie) {
    _headers = {};
    for (String item in cookie.split(";")) {
      int index = item.indexOf("=");
      debugPrint("sss,$item,$index,${item.substring(0, index)}");
      String key = item.substring(0, index).trim();
      String value = item.substring(index, item.length).trim();
      if (value.startsWith("=")) {
        value = value.substring(1, value.length);
      }
      debugPrint("_setHttpClientCookie,$key,$value");
      _headers[key] = value;
    }
    HttpUtil.setHeaders(_headers);
  }
}
