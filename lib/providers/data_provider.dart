import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/node_model.dart';

part 'data_provider.g.dart';

// final homeDataProvider = StreamProvider<HomeData>((ref) async* {
//   final data = await NodeApi.getHomeData();
//
// });

@riverpod
Future<HomeData> homeDataProvider(HomeDataProviderRef ref) async {
  return await NodeApi.getHomeData();
}

final nodeListProvider = FutureProvider<List<Node>>((ref) async {
  return NodeApi.getAllList();
});

final planListProvider = FutureProvider<List<Plan>>((ref) async {
  return NodeApi.getPlanList();
});

