import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/model/cache_model.dart';

class DataService {

  Future<void> loadHomeData(BuildContext context) async {
    final homeDataProvider = Provider.of<HomeData>(context);

    HomeData homeData = await NodeApi.getHomeData();

    if (homeDataProvider.tabList.isEmpty ||
        homeDataProvider.topicHeadList.isEmpty ||
        homeDataProvider.topicHotList.isEmpty) {

      debugPrint("main >>> ${jsonEncode(homeData.topicHeadList[0])}");

    }
  }
}