import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'node_model.dart';
import 'topic_model.dart';

class CookieData {
  String cookie;

  CookieData(this.cookie);
}

class HomeData with ChangeNotifier {
  List<NodeTab> _tabList = [];
  List<TopicHead> _topicHeadList = [];
  List<TopicHead> _topicHotList = [];

  List<NodeTab> get tabList => _tabList;

  List<TopicHead> get topicHeadList => _topicHeadList;

  List<TopicHead> get topicHotList => _topicHotList;

  HomeData(this._tabList, this._topicHeadList, this._topicHotList);

  Future<void> saveData(
      {List<NodeTab>? tabList,
      List<TopicHead>? topicHeadList,
      List<TopicHead>? topicHotList}) async {
    final prefs = await SharedPreferences.getInstance();
    if (null != tabList) {
      _tabList = tabList;
      prefs.setString('tabList', jsonEncode(tabList));
    }
    if (null != topicHeadList) {
      _topicHeadList = topicHeadList;
      prefs.setString('topicHeadList', jsonEncode(topicHeadList));
    }
    if (null != topicHotList) {
      _topicHotList = topicHotList;
      prefs.setString('topicHotList', jsonEncode(topicHotList));
    }
    notifyListeners();
  }
}
