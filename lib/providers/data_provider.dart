import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/node_model.dart';

part 'data_provider.g.dart';

final tabIndexProvider = StateProvider((ref) => 0);

@riverpod
Future<HomeData> homeDataProvider(HomeDataProviderRef ref) async {
  var tabProviderData = ref.watch(tabIndexProvider);

  var tabHref = AppConfig.tabList.isEmpty
      ? AppConfig.defaultTab
      : AppConfig.tabList[tabProviderData].href;

  var homeData = await NodeApi.getHomeData(currentTab: tabHref);
  if (AppConfig.tabList.isEmpty || AppConfig.topicHotList.isEmpty) {
    AppConfig.tabList = homeData.tabList;
    AppConfig.topicHotList = homeData.topicHotList;
  }
  return homeData;
}

final nodeListProvider = FutureProvider<List<Node>>((ref) async {
  return NodeApi.getAllList();
});

final planListProvider = FutureProvider<List<Plan>>((ref) async {
  return NodeApi.getPlanList();
});
