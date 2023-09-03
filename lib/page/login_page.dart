import 'package:flutter/material.dart';
import 'package:v2es/constant/assets_constant.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/image_load_widget.dart';
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
        backIcon: Icons.close_rounded,
        title: Container(
          alignment: Alignment.center,
          child: Image.asset(
            AssetsConstant.commonLogo,
            width: 20,
            height: 20,
          ),
        ),
        actions: [
          GestureDetector(
            child: const Text(
              '注册',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () => {},
          ),
          SizedBox(
            width: CommonUtil.getScreenWidth(context) * 0.05,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                "Log in",
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () => {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.g_translate_rounded),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text("Continue with Goolge"),
                    ),
                  ),
                ],
              ),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(1),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 1,
                  color: Colors.grey,
                  width: CommonUtil.getScreenWidth(context) * 0.42,
                ),
                Text(
                  "OR",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0,
                  ),
                ),
                Container(
                  height: 1,
                  color: Colors.grey,
                  width: CommonUtil.getScreenWidth(context) * 0.42,
                ),
              ],
            ),
            SizedBox(height: 15),
            Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "用户名或电子邮件",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 12, textBaseline: TextBaseline.alphabetic),
                ),
                cursorHeight: 25,
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 45,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "密码",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  hintStyle: TextStyle(
                      fontSize: 12, textBaseline: TextBaseline.alphabetic),
                ),
                cursorHeight: 25,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ImageLoader(
                  imageUrl: 'https://crates.io/assets/cargo.png',
                  width: CommonUtil.getScreenWidth(context) * 0.35,
                  height: CommonUtil.getScreenHeight(context) * 0.08,
                  circular: 5,
                  enableEnlarge: true,
                ),
                Container(
                  width: CommonUtil.getScreenWidth(context) * 0.55,
                  height: CommonUtil.getScreenHeight(context) * 0.08,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "验证码",
                      hintStyle: TextStyle(
                          fontSize: 14, textBaseline: TextBaseline.alphabetic),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              child: Text(
                "忘记密码",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onTap: () => {},
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        height: 50,
        padding: EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => {},
          child: Container(
            alignment: Alignment.center,
            child: Text("登录"),
          ),
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(1),
          ),
        ),
      ),
    );
  }
}
