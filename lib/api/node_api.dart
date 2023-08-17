import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:v2es/util/http_util.dart';

import '../constant/base_constant.dart';
import 'package:html/parser.dart' as html_parse;

class NodeApi {
  static Future<List<String>> getHomeTopics(
      Map<String, dynamic> hearders) async {
    Response response = await HttpUtil.get(ApiEndpoints.baseUrl,
        options: Options(headers: hearders));
    var document = html_parse.parse(response.data);
    var eleTabs = document.querySelectorAll('a[href^="/?tab="]');
    var tabs = [];
    for (var tab in eleTabs) {
      debugPrint(
          "${tab.text}：${tab.attributes['href']} ${tab.attributes['class'] == 'tab_current' ? '*' : ''}");
    }
    var eleTopicLinks = document.getElementsByClassName("topic-link");
    debugPrint("------------------Topic------------------");
    List<String> topics = [];
    for (var topic in eleTopicLinks) {
      debugPrint("${topic.attributes['href']}：${topic.text}");
      topics.add(topic.attributes['href']!);
    }
    return topics;
  }
}
