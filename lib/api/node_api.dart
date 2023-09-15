import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/util/http_util.dart';

import 'package:html/parser.dart' as html_parse;

class NodeApi {
  static Future<HomeData> getHomeData({Map<String, dynamic>? headers}) async {
    if (null != headers) {
      HttpUtil.setHeaders(headers);
    }
    Response response = await HttpUtil.get(ApiEndpoints.baseUrl);
    var document = html_parse.parse(response.data);

    List<NodeTab> tabList = [];
    var eleTabs = document.querySelectorAll('a[href^="/?tab="]');
    for (var tab in eleTabs) {
      debugPrint(
          "${tab.text}：${tab.attributes['href']} ${tab.attributes['class'] == 'tab_current' ? '*' : ''}");
      var tabName = tab.text;
      var tabHref = tab.attributes['href'];
      if (null != tabHref) {
        tabList.add(NodeTab(name: tabName, href: tabHref));
      }
    }

    var eleTopicList = document.getElementsByClassName('cell item');
    List<TopicHead> topicHeadList = [];
    for (var item in eleTopicList) {
      var eleTds = item.getElementsByTagName("td");
      if (eleTds.isNotEmpty && eleTds.length == 4) {
        var avatar = eleTds[0].querySelector("img")?.attributes['src'];
        var eleTopicLink = eleTds[2].querySelector("a[class='topic-link']");
        if (null != eleTopicLink) {
          var title = eleTopicLink.text;
          var href = eleTopicLink.attributes['href'];

          var eleTopicInfo =
              eleTds[2].querySelector("span[class='topic_info']");
          var eleTopicNodeInfo = eleTopicInfo?.querySelector("a[class='node']");
          var nodeHref = eleTopicNodeInfo?.attributes['href'];
          var nodeTitle = eleTopicNodeInfo?.text;
          var eleStrongTags = eleTopicInfo?.querySelectorAll("strong");
          String? authorHref, authorName, lastReplyHref, lastReplyName, rankUp;
          if (null != eleStrongTags) {
            authorHref = eleStrongTags[0].firstChild?.attributes['href'];
            authorName = eleStrongTags[0].firstChild?.text;
            if (eleStrongTags.length > 1) {
              lastReplyHref = eleStrongTags[1].firstChild?.attributes['href'];
              lastReplyName = eleStrongTags[1].firstChild?.text;
            }
          }
          rankUp =
              eleTopicInfo?.querySelector("div[class='votes']")?.text.trim();
          if (null == rankUp || rankUp.isEmpty) {
            rankUp = "0";
          }
          debugPrint("xxx =-> $rankUp");
          DateTime? lastReplyTime;
          var replyTime =
              eleTopicInfo?.getElementsByTagName("span")[0].attributes['title'];
          if (null != replyTime) {
            lastReplyTime = DateTime.tryParse(replyTime);
          }
          String replyQty =
              eleTds[3].querySelector("a[class='count_livid']")?.text ?? "0";

          if (null != href) {
            topicHeadList.add(TopicHead(title, href,
                authorHref: authorHref,
                authorName: authorName,
                avatar: avatar,
                nodeHref: nodeHref,
                nodeTitle: nodeTitle,
                rankUp: int.parse(rankUp),
                replyQty: int.parse(replyQty),
                lastReplyHref: lastReplyHref,
                lastReplyTime: lastReplyTime,
                lastReplyName: lastReplyName));
          }
        }
      }
    }

    List<TopicHead> topicHotList = [];
    var eleHotTopics =
        document.getElementById("TopicsHot")?.getElementsByTagName("table");
    if (null != eleHotTopics) {
      for (var ht in eleHotTopics) {
        var eleArr = ht.getElementsByTagName('a');
        if (eleArr.isNotEmpty && eleArr.length > 1) {
          var hotAuthorHref = eleArr[0].attributes['href'];
          var hotAvatar =
              eleArr[0].getElementsByTagName("img")[0].attributes['src'];
          var hotTitle = eleArr[1].text;
          var hotHref = eleArr[1].attributes['href'];
          debugPrint("$hotAuthorHref,$hotAvatar,$hotTitle,$hotHref");
          if (null != hotHref) {
            topicHotList.add(TopicHead(hotTitle, hotHref,
                avatar: hotAvatar, authorHref: hotAuthorHref));
          }
        }
      }
    }
    return HomeData(tabList, topicHeadList, topicHotList);
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
          String planName = CommonUtil.extractChinese(planInfo[0]);
          var subName = planInfo[0].replaceAll(planName, "");
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
            String icon = eleHeaders[0]
                    .querySelector('img[align="absmiddle"]')
                    ?.attributes['src'] ??
                "";
            String? color;
            String? backgroundColor;
            for (var item in eleHeaders[0].styles) {
              if (item.property == "color") {
                color = item.value?.span?.text;
              }
              if (item.property == "background-color") {
                backgroundColor = item.value?.span?.text;
              }
            }
            color ??= CommonUtil.colorToHex(AppConfig.schemeColor);
            backgroundColor ??= CommonUtil.colorToHex(AppConfig.schemeColor);
            planList.add(Plan(planName, subName, nodeList, qty, icon, color,
                backgroundColor));
          }
        }
      }
    }
    return planList;
  }
}
