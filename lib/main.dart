import 'package:flutter/material.dart';
import 'package:v2es/page/home_page.dart';
import 'package:v2es/page/search_page.dart';
import 'package:v2es/page/unknown_page.dart';

void main() async {
  runApp(const MyApp());
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
          default:
            return MaterialPageRoute(builder: (context) => const UnknownPage());
        }
      },
    );
  }
}
