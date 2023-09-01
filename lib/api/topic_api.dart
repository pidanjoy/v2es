import 'package:dio/dio.dart';
import 'package:v2es/model/topic_model.dart';

import '../constant/base_constant.dart';
import '../util/http_util.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:flutter/material.dart';

class TopicApi {
  static Future<Topic?> getTopicDetail(String topicUri,
      {Map<String, dynamic>? headers}) async {
    if (null != headers) {
      HttpUtil.setHeaders(headers);
    }
    Response response = await HttpUtil.get(ApiEndpoints.baseUrl + topicUri);
    var document = html_parse.parse(response.data);
    debugPrint("------------------------Title------------------------");
    var eleHeader = document.querySelector('div[class="header"]');
    String? title = eleHeader?.querySelector("h1")?.text;
    debugPrint("title => $title");
    var eleNode = eleHeader?.querySelector("a[href^='/go/']");
    String? nodeTitle = eleNode?.text;
    String? nodeHref = eleNode?.attributes['href'];
    debugPrint("node => $nodeTitle > $nodeHref");
    var eleMember = eleHeader?.querySelector("div[class='fr'] > a");
    String authorHref = eleMember?.attributes['href'] ?? "";
    String authorAvatar = eleMember?.firstChild?.attributes['src'] ?? "";
    String authorName = eleMember?.firstChild?.attributes['alt'] ?? "佚名";
    debugPrint("author => $authorName > $authorHref > $authorAvatar");
    String? likeCount = eleHeader
        ?.querySelector("div[class='votes'] > a[onclick^='upVoteTopic']")
        ?.text
        .trim();
    if (null == likeCount || likeCount.isEmpty) {
      likeCount = "0";
    }
    debugPrint("likeCount => $likeCount");
    String? clickFavoriteThanks = eleHeader
        ?.querySelector(
            "div[class='topic_buttons'] > div[class='fr topic_stats']")
        ?.text
        .trim();
    String releaseTime =
        eleHeader?.querySelector("span[title^='20']")?.attributes['title'] ??
            "";
    String clickCount = "0", favoriteCount = "0", thanksCount = "0";
    if (null != clickFavoriteThanks) {
      List<String> clickFavoriteThanksSplit = clickFavoriteThanks.split("次点击");
      if (clickFavoriteThanksSplit[0].isNotEmpty) {
        clickCount = clickFavoriteThanksSplit[0];
      }
      clickFavoriteThanksSplit.removeAt(0);
      clickFavoriteThanksSplit = clickFavoriteThanksSplit.join().split("人收藏");
      if (clickFavoriteThanksSplit[0].isNotEmpty) {
        favoriteCount = clickFavoriteThanksSplit[0];
      }
      clickFavoriteThanksSplit.removeAt(0);
      clickFavoriteThanksSplit = clickFavoriteThanksSplit.join().split("人感谢");
      if (clickFavoriteThanksSplit[0].isNotEmpty) {
        thanksCount = clickFavoriteThanksSplit[0];
      }
    }
    debugPrint("clickCount => $clickCount");
    debugPrint("favoriteCount => $favoriteCount");
    debugPrint("thanksCount => $thanksCount");
    debugPrint("------------------------Content------------------------");
    String? contextHtml = document.querySelector(".topic_content")?.outerHtml;
    debugPrint("context => $contextHtml");
    String? postscript = document.querySelector(".subtle")?.outerHtml;
    debugPrint("postscript => $postscript");
    debugPrint("------------------------Tag------------------------");
    List<TopicTag> tags = [];
    var eleTags = document.querySelectorAll('a[href^="/tag/"]');
    String replyCount = "0", lastReplyTime = "";
    if (eleTags.isNotEmpty) {
      for (var tag in eleTags) {
        debugPrint(tag.text);
        tags.add(TopicTag(tag.text, tag.attributes['href']!));
      }
      String? replyInfo = document
          .querySelector(
              "div[class='box'] > div[class='cell'] > span[class='gray']")
          ?.text
          .trim();
      if (null != replyInfo) {
        List<String> replyCountSplit = replyInfo.split("条回复");
        if (replyCountSplit[0].isNotEmpty) {
          replyCount = replyCountSplit[0];
        }
        lastReplyTime = replyCountSplit[1].replaceAll("•", "").trim();
      }
      debugPrint("replyCount => $replyCount");
      debugPrint("lastReplyTime => $lastReplyTime");
    }
    debugPrint("------------------------Reply------------------------");
    List<TopicReply>? replies = [];
    var eleReplies = document.querySelectorAll(".box > [id^='r_']");
    for (var reply in eleReplies) {
      String? replyContext = reply.querySelector(".reply_content")?.outerHtml;
      debugPrint(replyContext);
      String replyAvatar =
          reply.querySelector("img[class='avatar']")?.attributes['src'] ?? "";
      String replyTime =
          reply.querySelector("span[class='ago']")?.attributes['title'] ?? "";
      var eleReplyMember = reply.querySelector("strong > a[href^='/member/']");
      String replyName = eleReplyMember?.text ?? "佚名";
      String replyHref = eleReplyMember?.attributes['href'] ?? "";
      String replyLevel =
          reply.querySelector("div[class='fr'] > span[class='no']")?.text ??
              "0";
      String replyThanksCount =
          reply.querySelector("span[class='small fade']")?.text ?? "0";
      if (null != replyContext) {
        replies.add(TopicReply(
            context: replyContext,
            replyName: replyName,
            replyHref: replyHref,
            avatar: replyAvatar,
            thanksCount: int.parse(replyThanksCount),
            replyTime: DateTime.tryParse(replyTime) ?? DateTime.now(),
            level: int.parse(replyLevel)));
      }
    }
    debugPrint("------------------------Page------------------------");
    var elePage = document.querySelector('input[class="page_input"]');
    String? pageNo = elePage?.attributes['value'];
    String? pageSize = elePage?.attributes['max'];
    debugPrint("$pageNo < $pageSize");

    if (null != title && null != contextHtml) {
      return Topic(
          title: title,
          href: topicUri,
          context: contextHtml,
          authorName: authorName,
          authorHref: authorHref,
          avatar: authorAvatar,
          releaseTime: DateTime.tryParse(releaseTime) ?? DateTime.now(),
          postscript: postscript,
          likeCount: int.parse(likeCount),
          clickCount: int.parse(clickCount),
          favoriteCount: int.parse(favoriteCount),
          thanksCount: int.parse(thanksCount),
          nodeTitle: nodeTitle,
          nodeHref: nodeHref,
          replyCount: int.parse(replyCount),
          lastReplyTime: DateTime.tryParse(lastReplyTime) ?? DateTime.now(),
          tags: tags,
          replies: replies,
          pageNo: pageNo != null ? int.parse(pageNo) : 0,
          pageSize: pageSize != null ? int.parse(pageSize) : 0);
    }
    return null;
  }
}
