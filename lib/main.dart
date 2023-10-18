import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/config/route_config.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/page/launch_page.dart';
import 'package:v2es/theme/common_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppConfig().init();
  // HomeData homeData = await NodeApi.getHomeData();
  // debugPrint("main >>> ${jsonEncode(homeData.topicHeadList[0])}");
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: HomeData.empty()),
    Provider(
      create: (_) => NodeApi.getPlanList(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.gAppName,
      themeMode: ThemeMode.system,
      theme: CommonTheme.lightTheme,
      darkTheme: CommonTheme.darkTheme,
      home: const LaunchPage(),
      debugShowCheckedModeBanner: false,
      routes: myRoutes,
      onGenerateRoute: myGenerateRoute,
    );
  }
}
