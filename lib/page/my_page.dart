import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/image_load_widget.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 1),
            child: Container(
              height: CommonUtil.getScreenHeight(context) * 0.15,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/my_page_bg.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () =>
                    CommonUtil.routeTo(context, RouteName.setting),
                icon: Icon(
                  Icons.notifications_active_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              IconButton(
                onPressed: () =>
                    CommonUtil.routeTo(context, RouteName.setting),
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: CommonUtil.getScreenHeight(context) * 0.02),
              ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: ImageLoader(
                        imageUrl: "https://crates.io/assets/cargo.png",
                      ),
                    ),
                  ),
                ),
                title: Text(
                  "Test nickname",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "今日活跃度排名 4739",
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "V2EX 第 513215 号会员，加入于 ${CommonUtil.formatTimeDifference(DateTime.parse('2020-10-17 17:37:44 +08:00'))}前",
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: DefaultTabController(
                  length: 7,
                  child: Scaffold(
                    appBar: AppBar(
                      title: Center(
                        child: TabBar(
                          isScrollable: true,
                          tabs: [
                            Tab(
                              text: "回复",
                            ),
                            Tab(
                              text: "提问",
                            ),
                            Tab(
                              text: "技术",
                            ),
                            Tab(
                              text: "好玩",
                            ),
                            Tab(
                              text: "工作",
                            ),
                            Tab(
                              text: "交易",
                            ),
                            Tab(
                              text: "城市",
                            ),
                          ],
                        ),
                      ),
                    ),
                    body: TabBarView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListView(
                            children: [
                              Container(height: 100, color: Colors.cyan),
                              Container(height: 100, color: Colors.red),
                              Container(height: 100, color: Colors.grey),
                              Container(height: 100, color: Colors.white),
                              Container(height: 100, color: Colors.yellow),
                              Container(height: 100, color: Colors.deepPurple),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("2"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("3"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("4"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("5"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("6"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("7"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
