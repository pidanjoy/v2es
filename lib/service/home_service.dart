import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/providers/data_provider.dart';

class HomeService {
  static HomeData refreshHomeData(WidgetRef ref) {
    return ref.refresh(homeDataProviderProvider).value ?? HomeData.empty();
  }
}
