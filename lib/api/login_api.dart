import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:v2es/util/http_client.dart';

import '../model/user_model.dart';

class LoginApi {
  static const v2exUrl = "https://www.v2ex.com";

  static const loginKeyUrl = "$v2exUrl/signin";
  static const captchaImageUrl = "$v2exUrl/_captcha";
  static const loginUrl = "$v2exUrl/signin";

  Future<LoginKey?> getLoginKey() async {
    String? cookie, username, password, captcha, once, next;
    Response response = await ReqClient().get(loginKeyUrl);
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

  Future<Uint8List> getCaptchaImage(Map<String, dynamic> hearders) async {
    Response response = await ReqClient().get(captchaImageUrl,
        options: Options(responseType: ResponseType.bytes, headers: hearders));
    return response.data;
  }

  Future<String?> loginPickCookie(
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

    Response response =
        await ReqClient().postForm(loginUrl, params, options: options);
    if (response.statusCode == 302) {
      return response.headers["set-cookie"]!.join(";");
    } else {
      return null;
    }
  }
}
