import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:v2es/util/common_util.dart';

class AppConfig {
  late String _appName;
  late Color _schemeColor;

  late bool _proxyEnable;
  late String _proxyHost;
  late int _proxyPort;

  late bool _autoSignIn;

  late String _v2Cookie;

  String get appName => _appName;

  Color get schemeColor => _schemeColor;

  bool get proxyEnable => _proxyEnable;

  String get proxyHost => _proxyHost;

  int get proxyPort => _proxyPort;

  bool get autoSignIn => _autoSignIn;

  String get v2Cookie => _v2Cookie;

  set appName(String value) {
    _appName = value;
    _prefs.setString("appName", value);
  }

  set schemeColor(Color value) {
    _schemeColor = value;
    _prefs.setString("schemeColor", CommonUtil.colorToHex(value));
  }

  set proxyEnable(bool value) {
    _proxyEnable = value;
    _prefs.setBool("proxyEnable", value);
  }

  set proxyHost(String value) {
    _proxyHost = value;
    _prefs.setString("proxyHost", value);
  }

  set proxyPort(int value) {
    _proxyPort = value;
    _prefs.setInt("proxyPort", value);
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

  static bool get gProxyEnable => _instance.proxyEnable;

  static String get gProxyHost => _instance.proxyHost;

  static int get gProxyPort => _instance.proxyPort;

  static bool get gAutoSignIn => _instance.autoSignIn;

  static String get gV2Cookie => _instance.v2Cookie;

  static set gAppName(String value) {
    _instance.appName = value;
  }

  static set gSchemeColor(Color value) {
    _instance.schemeColor = value;
  }

  static set gProxyEnable(bool value) {
    _instance.proxyEnable = value;
  }

  static set gProxyHost(String value) {
    _instance.proxyHost = value;
  }

  static set gProxyPort(int value) {
    _instance.proxyPort = value;
  }

  static set gAutoSignIn(bool value) {
    _instance.autoSignIn = value;
  }

  static set gV2Cookie(String value) {
    _instance.v2Cookie = value;
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
    _instance.proxyEnable = _prefs.getBool("proxyEnable") ?? false;
    _instance.proxyHost = _prefs.getString("proxyHost") ?? "127.0.0.1";
    _instance.proxyPort = _prefs.getInt("proxyPort") ?? 7890;
    _instance.autoSignIn = _prefs.getBool("autoSignIn") ?? true;
    _instance.v2Cookie = _prefs.getString("v2Cookie") ?? "";
  }
}
