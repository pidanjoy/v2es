import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/page/home_page.dart';
import 'package:v2es/page/search_page.dart';
import 'package:v2es/page/topic_page.dart';
import 'package:v2es/page/unknown_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HomeData homeData = await NodeApi.getHomeData();
  debugPrint("main >>> ${jsonEncode(homeData.topicHeadList[0])}");

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: homeData),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'V2ES',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      home: const HomePage(title: 'V2ES'),
      debugShowCheckedModeBanner: false,
      routes: {
        "/home": (context) => const HomePage(title: 'V2ES'),
      },
      onGenerateRoute: (setting) {
        switch (setting.name) {
          case "/search":
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const SearchPage(),
            );
          case "/topic":
            return PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
              final dynamic argument = setting.arguments;
              return TopicPage(uri: argument);
            });
          default:
            return MaterialPageRoute(builder: (context) => const UnknownPage());
        }
      },
    );
  }
}
