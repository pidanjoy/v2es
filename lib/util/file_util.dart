import 'dart:io';

import 'package:path_provider/path_provider.dart';

class FileUtil {
  static Future<Directory> get cacheDir {
    final dir = getTemporaryDirectory();
    return dir;
  }

  static Future<Directory> get dataDir {
    final dir = getApplicationDocumentsDirectory();
    return dir;
  }

  static Future<File> getCacheFile(String fileName, {String? childDir}) async {
    String dirPath = (await cacheDir).path;
    return _getLocalFile(dirPath, fileName, childDir);
  }

  static Future<File> getDataFile(String fileName, {String? childDir}) async {
    final dirPath = (await dataDir).path;
    return _getLocalFile(dirPath, fileName, childDir);
  }

  static Future<File> _getLocalFile(
      String dirPath, String fileName, String? childDir) async {
    if (null != childDir) {
      dirPath += childDir;
    }
    return File(dirPath + Platform.pathSeparator + fileName);
  }
}
