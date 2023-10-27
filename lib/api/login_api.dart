import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parse;

import '../model/login_model.dart';
import '../constant/base_constant.dart';
import '../util/http_util.dart';

class LoginApi {
  static Future<LoginKey?> getLoginKey() async {
    String? cookie, username, password, captcha, once, next;
    Response response = await HttpUtil.get(ApiEndpoints.loginKeyUrl);
    cookie = response.headers["set-cookie"]!.join(";");

    var document = html_parse.parse(response.data);
    var tables = document.getElementsByClassName("sl");
    for (var element in tables) {
      var eleName = element.attributes["name"];
      var eleType = element.attributes["type"];
      if (eleType == "password") {
        password = eleName;
      } else {
        var elePlaceholder = element.attributes["placeholder"];
        if (elePlaceholder!.contains("用户名")) {
          username = eleName;
        } else if (elePlaceholder.contains("验证码")) {
          captcha = eleName;
        }
      }
    }

    var eleOnce = document.querySelector("[name=once]");
    if (null != eleOnce) {
      once = eleOnce.attributes['value'];
    }
    var eleNext = document.querySelector("[name=next]");
    if (null != eleNext) {
      next = eleNext.attributes['value'] ?? "/";
    }

    debugPrint(
        "loginKey: $cookie, $username, $password, $captcha, $once, $next");
    if (null == username ||
        null == password ||
        null == captcha ||
        null == once ||
        null == next) {
      return null;
    }
    return LoginKey(
        cookie: cookie,
        username: username,
        password: password,
        captcha: captcha,
        once: once,
        next: next);
  }

  static Future<Uint8List> getCaptchaImage(
      Map<String, dynamic> hearders) async {
    Response response = await HttpUtil.get(ApiEndpoints.captchaImageUrl,
        options: Options(responseType: ResponseType.bytes, headers: hearders));
    return response.data;
  }

  static Future<String?> loginPickCookie(
      LoginParams loginParams, Map<String, dynamic> hearders) async {
    Map<String, dynamic> params = {
      loginParams.usernameKey: loginParams.usernameValue,
      loginParams.passwordKey: loginParams.passwordValue,
      loginParams.captchaKey: loginParams.captchaValue,
      "once": loginParams.once,
      "next": loginParams.next
    };
    var options = Options(
        headers: hearders,
        followRedirects: false,
        validateStatus: (status) => null == status ? false : status < 500);

    Response response = await HttpUtil.postForm(ApiEndpoints.loginUrl, params,
        options: options);
    debugPrint("login >> ${response}");
    if (response.statusCode == 302) {
      return response.headers["set-cookie"]!.join(";");
    } else {
      return null;
    }
  }
}
