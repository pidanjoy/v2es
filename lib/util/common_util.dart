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
      return "${difference.inMinutes}分钟前";
    } else if (difference < const Duration(days: 1)) {
      return "${difference.inHours}小时前";
    } else if (difference < const Duration(days: 30)) {
      return "${difference.inDays}天前";
    } else if (difference < const Duration(days: 365)) {
      return "${(difference.inDays / 30).floor()}个月前";
    } else {
      return "${(difference.inDays / 365).floor()}年前";
    }
  }
}
