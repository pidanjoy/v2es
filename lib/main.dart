import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/config/route_config.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().init();
  HomeData homeData = await NodeApi.getHomeData();
  debugPrint("main >>> ${jsonEncode(homeData.topicHeadList[0])}");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: homeData),
    Provider(
      create: (_) => NodeApi.getPlanList(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppConfig.gSchemeColor = Colors.cyan;
    return MaterialApp(
      title: AppConfig.gAppName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppConfig.gSchemeColor),
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: HomePage(title: AppConfig.gAppName),
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
      onGenerateRoute: myGenerateRoute,
    );
  }
}
