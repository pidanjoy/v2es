import 'package:flutter/material.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/constant/base_constant.dart';

class CommonUtil {
  static String limitText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static String getTextIdent(String text) {
    return "${text.hashCode}";
  }

  static String formatTimeDifference(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference < const Duration(minutes: 1)) {
      return "刚刚";
    } else if (difference < const Duration(hours: 1)) {
      return "${difference.inMinutes}分钟";
    } else if (difference < const Duration(days: 1)) {
      return "${difference.inHours}小时";
    } else if (difference < const Duration(days: 30)) {
      return "${difference.inDays}天";
    } else if (difference < const Duration(days: 365)) {
      return "${(difference.inDays / 30).floor()}个月";
    } else {
      return "${(difference.inDays / 365).floor()}年";
    }
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery
        .of(context)
        .size
        .height;
  }

  static Future<T?> routeTo<T extends Object?>(BuildContext context,
      RouteName routeName,
      {Object? arguments}) {
    return Navigator.pushNamed(context, routeName.r, arguments: arguments);
  }

  static Iterable<RegExpMatch> extractChineseList(String str) {
    RegExp regExp = RegExp(r"[\u4e00-\u9fff]+");
    return regExp.allMatches(str);
  }

  static String extractChinese(String str) {
    return extractChineseList(str).map((match) => match.group(0)).join("");
  }

  static String colorToHex(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0').substring(2)}';
  }

  static Color hexToColor(String code) {
    if (code.startsWith('#')) {
      code = code.substring(1);
    }
    if (code.length != 6) {
      return AppConfig.gSchemeColor;
    }
    return Color(int.parse(code, radix: 16) + 0xFF000000);
  }
}
