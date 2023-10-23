library base_constant;

import 'package:flutter/foundation.dart';

const double gravity = 9.8;
const int maxAttempts = 3;

class ApiEndpoints {
  static const baseUrl = "https://www.v2ex.com";

  static const loginKeyUrl = "$baseUrl/signin";
  static const captchaImageUrl = "$baseUrl/_captcha";
  static const loginUrl = "$baseUrl/signin";
  static const planesUrl = "$baseUrl/planes";
  static const forgotPasswordUrl = "$baseUrl/forgot";

  static userReplyUrl(username) => "$baseUrl/member/$username";

  static userQuestionUrl(username) => "$baseUrl/member/$username/qna";

  static userTechUrl(username) => "$baseUrl/member/$username/tech";

  static userPlayUrl(username) => "$baseUrl/member/$username/play";

  static userDealUrl(username) => "$baseUrl/member/$username/deals";

  static userCityUrl(username) => "$baseUrl/member/$username/city";

  static const nodeAllUrl =
      "$baseUrl/api/nodes/list.json?fields=name,title,topics,aliases&sort_by=topics&reverse=1";
}

enum RouteName {
  home,
  search,
  login,
  topic,
  plan,
  setting,
  proxyConfig,
}

extension RouteNameExtension on RouteName {
  String get name => describeEnum(this);

  String get r {
    switch (this) {
      case RouteName.home:
        return "/home";
      case RouteName.search:
        return "/search";
      case RouteName.login:
        return "/login";
      case RouteName.topic:
        return "/topic";
      case RouteName.plan:
        return "/plan";
      case RouteName.setting:
        return "/setting";
      case RouteName.proxyConfig:
        return "/proxyConfig";
    }
  }
}
