import 'package:flutter/material.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  static const List settingList = [{}, {}, {}];

  var _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          size: CommonUtil.getScreenHeight(context) * 0.06,
          title: const Text(
            "设置",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
        body: Container(
          color: Color.fromRGBO(229, 229, 229, 1.0),
          child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "我的",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),

              Container(
                color: Colors.white,
                height: CommonUtil.getScreenHeight(context) * 0.06,
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.only(left: 5, right: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("自动签到"),
                    Container(
                      height: 10,
                      child: Switch(value: _switchValue, onChanged: (value) {
                        setState(() {
                          _switchValue = value;
                        });
                      }),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "通用",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: CommonUtil.getScreenHeight(context) * 0.06,
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.only(left: 5, right: 7),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("代理设置"),
                    Icon(Icons.chevron_right_outlined),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: CommonUtil.getScreenHeight(context) * 0.06,
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.only(left: 5, right: 7),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("清理缓存"),
                    Icon(Icons.chevron_right_outlined),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "关于",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                height: CommonUtil.getScreenHeight(context) * 0.06,
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.only(left: 5, right: 7),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("关于V2ES"),
                    Icon(Icons.chevron_right_outlined),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () => {}, child: Text("退出登录")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
