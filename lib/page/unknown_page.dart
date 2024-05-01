import 'package:flutter/material.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/util/common_util.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TextButton(
            onPressed: () => CommonUtil.routeTo(context, RouteName.home),
            child: const Text("< 首页 \n未知错误")),
      ),
    );
  }
}
