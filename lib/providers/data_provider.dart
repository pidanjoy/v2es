import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/node_model.dart';

part 'data_provider.g.dart';

// final homeDataProvider = StreamProvider<HomeData>((ref) async* {
//   final data = await NodeApi.getHomeData();
//
// });

final tabProvider = StateProvider((ref) => "hot");

@riverpod
Future<HomeData> homeDataProvider(HomeDataProviderRef ref) async {
  var tabProviderData = ref.watch(tabProvider);

  HomeData homeData = await NodeApi.getHomeData(currentTab: tabProviderData);
  if (AppConfig.topicHeadList.isEmpty || AppConfig.tabList.isEmpty) {
    AppConfig.topicHeadList = homeData.topicHeadList;
    AppConfig.tabList = homeData.tabList;
  }
  return homeData;
}

final nodeListProvider = FutureProvider<List<Node>>((ref) async {
  return NodeApi.getAllList();
});

final planListProvider = FutureProvider<List<Plan>>((ref) async {
  return NodeApi.getPlanList();
});
