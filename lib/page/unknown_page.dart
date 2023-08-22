import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
            onPressed: () => Navigator.pushNamed(context, "/home"),
            child: const Text("< 首页 \n未知错误")),
      ),
    );
  }
}
