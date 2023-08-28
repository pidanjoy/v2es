import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/util/http_util.dart';

import 'package:html/parser.dart' as html_parse;

class NodeApi {
  static Future<List<String>> getHomeTopics(
  {Map<String, dynamic>? headers}) async {
    if (null != headers) {
      HttpUtil.setHeaders(headers);
    }
    Response response = await HttpUtil.get(ApiEndpoints.baseUrl);
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
    debugPrint("------------------Hot------------------");
    var eleHotTopics =
        document.getElementById("TopicsHot")?.getElementsByTagName("table");
    if (null != eleHotTopics) {
      for (var ht in eleHotTopics) {
        var eleArr = ht.getElementsByTagName('a');
        if (eleArr.isNotEmpty && eleArr.length > 1) {
          var memberUrl = eleArr[0].attributes['href'];
          var avatarUrl =
              eleArr[0].getElementsByTagName("img")[0].attributes['src'];
          var topicTitle = eleArr[1].text;
          var topicUrl = eleArr[1].attributes['href'];
          debugPrint("$memberUrl,$avatarUrl,$topicTitle,$topicUrl");
        }
      }
    }
    return topics;
  }

  static Future<List<Node>> getAllList() async {
    Response response = await HttpUtil.get(ApiEndpoints.nodeAllUrl);
    List<Node> nodeList = [];
    if (response.statusCode == 200) {
      final jsonList = json.decode(response.data);
      if (jsonList is List) {
        nodeList =
            jsonList.map((jsonObject) => Node.fromJson(jsonObject)).toList();
        return nodeList;
      }
    }
    return nodeList;
  }

  static Future<List<Plan>> getPlanList() async {
    Response response = await HttpUtil.get(ApiEndpoints.planesUrl);
    List<Plan> planList = [];
    if (response.statusCode == 200) {
      var document = html_parse.parse(response.data);
      var elePlans =
          document.getElementById('Main')?.getElementsByClassName("box");
      if (null != elePlans && elePlans.length > 1) {
        elePlans = elePlans.sublist(1);

        for (var elePlan in elePlans) {
          var eleHeaders = elePlan.getElementsByClassName("header");
          var planInfo =
              eleHeaders[0].text.replaceAll("nodes", "").trim().split("•");
          var planName = planInfo[0];
          var qty = int.parse(planInfo[1]);

          if (eleHeaders.isNotEmpty) {
            List<Node> nodeList = [];
            var eleNodes = elePlan.getElementsByClassName("item_node");
            for (var node in eleNodes) {
              var nodeTitle = node.text;
              var nodeName = node.attributes['href']?.replaceAll("/go/", "");
              if (null != nodeName) {
                nodeList.add(Node(title: nodeTitle, name: nodeName, topics: 0));
              }
            }
            planList.add(Plan(planName, nodeList, qty));
          }
        }
      }
    }
    return planList;
  }
}
