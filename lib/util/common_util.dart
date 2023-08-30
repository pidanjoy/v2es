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
}
