import 'package:flutter/material.dart';

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

  void set(
      {List<NodeTab>? tabList,
      List<TopicHead>? topicHeadList,
      List<TopicHead>? topicHotList}) {
    if (null != tabList) {
      _tabList = tabList;
    }
    if (null != topicHeadList) {
      _topicHeadList = topicHeadList;
    }
    if (null != topicHotList) {
      _topicHotList = topicHotList;
    }
    notifyListeners();
  }
}
