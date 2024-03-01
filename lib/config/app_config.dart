import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2es/model/config_model.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/common_util.dart';

class AppConfig {
  late String _appName;
  late Color _schemeColor;
  late bool _autoSignIn;
  late String _v2Cookie;
  late ProxyParams _proxyParams;

  static const String defaultTab = "/?tab=hot";
  static List<NodeTab> tabList = [];
  static List<TopicHead> topicHotList = [];

  String get appName => _appName;

  Color get schemeColor => _schemeColor;

  bool get autoSignIn => _autoSignIn;

  String get v2Cookie => _v2Cookie;

  ProxyParams get proxyParams => _proxyParams;

  set proxyParams(ProxyParams value) {
    _proxyParams = value;
    _prefs.setString("proxyParams", convert.jsonEncode(value.toJson()));
  }

  set appName(String value) {
    _appName = value;
    _prefs.setString("appName", value);
  }

  set schemeColor(Color value) {
    _schemeColor = value;
    _prefs.setString("schemeColor", CommonUtil.colorToHex(value));
  }

  set autoSignIn(bool value) {
    _autoSignIn = value;
    _prefs.setBool("autoSignIn", value);
  }

  set v2Cookie(String value) {
    _v2Cookie = value;
    _prefs.setString("v2Cookie", value);
  }

  static String get gAppName => _instance.appName;

  static Color get gSchemeColor => _instance.schemeColor;

  static bool get gAutoSignIn => _instance.autoSignIn;

  static String get gV2Cookie => _instance.v2Cookie;

  static ProxyParams get gProxyParams => _instance.proxyParams;

  static set gAppName(String value) {
    _instance.appName = value;
  }

  static set gSchemeColor(Color value) {
    _instance.schemeColor = value;
  }

  static set gAutoSignIn(bool value) {
    _instance.autoSignIn = value;
  }

  static set gV2Cookie(String value) {
    _instance.v2Cookie = value;
  }

  static set gProxyParams(ProxyParams value) {
    _instance.proxyParams = value;
  }

  factory AppConfig() => _instance;

  AppConfig._internal();

  static final AppConfig _instance = AppConfig._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    _instance.appName = _prefs.getString("appName") ?? "V2ES";
    String? schemeColor = _prefs.getString("schemeColor");
    _instance.schemeColor = schemeColor != null
        ? CommonUtil.hexToColor(schemeColor)
        : Colors.deepPurple;
    _instance.autoSignIn = _prefs.getBool("autoSignIn") ?? true;
    _instance.v2Cookie = _prefs.getString("v2Cookie") ?? "";

    String? proxyParamsPrefs = _prefs.getString("proxyParams");
    if (null != proxyParamsPrefs) {
      _instance.proxyParams =
          ProxyParams.fromJson(convert.jsonDecode(proxyParamsPrefs));
    } else {
      _instance.proxyParams = ProxyParams();
    }
  }
}
