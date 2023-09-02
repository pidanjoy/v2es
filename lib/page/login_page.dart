import 'package:flutter/material.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        size: CommonUtil.getScreenHeight(context) * 0.06,
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
