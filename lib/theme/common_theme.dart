import 'package:flutter/material.dart';

class CommonTheme {
  static const double normalFontSize = 15;
  static const double titleFontSize = 20;
  static const double subTitleFontSize = 18;

  static const Color lightThemeTextColor = Colors.black;
  static const Color darkThemeTextColor = Colors.white;

  static const Color cardColorLight = Colors.white;
  static const Color cardColorDark = Colors.blueGrey;

  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // 点击TabBar过渡效果
    highlightColor: Colors.transparent,
    // 亮度，明亮模式
    brightness: Brightness.light,
    // 主要决定导航和底部BottomBar颜色
    primarySwatch: Colors.red,
    primaryColor: Colors.red,
    hintColor: Colors.blue,
    textTheme: const TextTheme(
      bodyLarge:
          TextStyle(fontSize: normalFontSize, color: lightThemeTextColor),
    ),
    buttonTheme: const ButtonThemeData(height: 25, minWidth: 10),
    cardTheme: const CardTheme(color: cardColorLight, elevation: 20),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    splashColor: Colors.transparent,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    highlightColor: Colors.transparent,
    brightness: Brightness.dark,
    primarySwatch: Colors.blueGrey,
    primaryColor: Colors.blueGrey,
    hintColor: Colors.blue,
    textTheme: const TextTheme(
        labelLarge:
            TextStyle(fontSize: normalFontSize, color: darkThemeTextColor)),
    buttonTheme: const ButtonThemeData(height: 25, minWidth: 10),
    cardTheme: const CardTheme(color: cardColorDark, elevation: 20),
  );
}
