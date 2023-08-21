import 'package:dio/dio.dart';

import '../constant/base_constant.dart';
import '../util/http_util.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:flutter/material.dart';

class TopicApi {
  static void getTopicDetail(
      String topicUri, Map<String, dynamic> hearders) async {
    Response response = await HttpUtil.get(ApiEndpoints.baseUrl + topicUri,
        options: Options(headers: hearders));
    var document = html_parse.parse(response.data);
    debugPrint("------------------Title------------------");
    var eleTitle = document.querySelector("title");
    debugPrint(eleTitle?.text.replaceAll(' - V2EX', ''));
    debugPrint("------------------Content------------------");
    var eleContent = document.querySelector(".topic_content");
    debugPrint(eleContent?.outerHtml);
    debugPrint("------------------Tag------------------");
    var eleTags = document.querySelectorAll('a[href^="/tag/"]');
    for (var tag in eleTags) {
      debugPrint(tag.text);
    }
    debugPrint("------------------Reply------------------");
    var eleReplys = document.querySelectorAll(".box > [id^='r_']");
    for (var reply in eleReplys) {
      debugPrint(reply.querySelector(".reply_content")?.outerHtml);
    }
  }
}