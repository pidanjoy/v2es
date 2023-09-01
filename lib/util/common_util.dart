import 'package:flutter/material.dart';

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
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}
