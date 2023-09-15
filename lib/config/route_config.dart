import 'package:flutter/material.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/page/home_page.dart';
import 'package:v2es/page/login_page.dart';
import 'package:v2es/page/plan_page.dart';
import 'package:v2es/page/search_page.dart';
import 'package:v2es/page/topic_page.dart';
import 'package:v2es/page/unknown_page.dart';

Map<String, WidgetBuilder> myRoutes = {
  RouteName.home.r: (context) => const HomePage(title: 'V2ES'),
};

RouteFactory myGenerateRoute = (setting) {
  if (setting.name == RouteName.search.r) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const SearchPage(),
    );
  } else if (setting.name == RouteName.login.r) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginPage(),
    );
  } else if (setting.name == RouteName.topic.r) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      final dynamic argument = setting.arguments;
      return TopicPage(uri: argument);
    });
  } else if (setting.name == RouteName.plan.r) {
    return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
      return const PlanPage();
    });
  } else {
    return MaterialPageRoute(builder: (context) => const UnknownPage());
  }
};
