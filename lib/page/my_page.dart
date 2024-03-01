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
              height: CommonUtil.getScreenHeight(context) * 0.17,
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
              // IconButton(
              //   onPressed: () => CommonUtil.routeTo(context, RouteName.setting),
              //   icon: Icon(
              //     Icons.notifications_active_rounded,
              //     color: Colors.white,
              //     size: 18,
              //   ),
              // ),
              IconButton(
                onPressed: () => CommonUtil.routeTo(context, RouteName.setting),
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: CommonUtil.getScreenHeight(context) * 0.015),
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
                title: GestureDetector(
                  onTap: () => CommonUtil.routeTo(context, RouteName.login),
                  child: Text(
                    "请先登录",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
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
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 1, right: 1),
                          child: Text(
                            "100",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Image(
                          image:
                              AssetImage("assets/images/currency/gold@2x.png"),
                          width: 10,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 1, right: 1),
                          child: Text(
                            "100",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage(
                              "assets/images/currency/silver@2x.png"),
                          width: 12,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 1, right: 1),
                          child: Text(
                            "100",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Image(
                          image: AssetImage(
                              "assets/images/currency/bronze@2x.png"),
                          width: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: CommonUtil.getScreenHeight(context) * 0.4,
                height: 45,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        width: CommonUtil.getScreenHeight(context) * 0.12,
                        child: GestureDetector(
                          onTap: () => {},
                          child: Row(
                            children: [
                              Icon(
                                Icons.mark_email_unread_outlined,
                                color: Colors.cyan,
                              ),
                              SizedBox(width: 5),
                              Text("200"),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: 1.0,
                        height: 20.0,
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: CommonUtil.getScreenHeight(context) * 0.12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.calendar_month_outlined),
                            SizedBox(width: 5),
                            Text("已签"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(
              //   child: DefaultTabController(
              //     length: 7,
              //     child: Scaffold(
              //       appBar: AppBar(
              //         title: Center(
              //           child: TabBar(
              //             isScrollable: true,
              //             tabs: [
              //               Tab(
              //                 text: "回复",
              //               ),
              //               Tab(
              //                 text: "提问",
              //               ),
              //               Tab(
              //                 text: "技术",
              //               ),
              //               Tab(
              //                 text: "好玩",
              //               ),
              //               Tab(
              //                 text: "工作",
              //               ),
              //               Tab(
              //                 text: "交易",
              //               ),
              //               Tab(
              //                 text: "城市",
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //       body: TabBarView(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(2.0),
              //             child: ListView(
              //               children: [
              //                 Container(height: 100, color: Colors.cyan),
              //                 Container(height: 100, color: Colors.red),
              //                 Container(height: 100, color: Colors.grey),
              //                 Container(height: 100, color: Colors.white),
              //                 Container(height: 100, color: Colors.yellow),
              //                 Container(height: 100, color: Colors.deepPurple),
              //               ],
              //             ),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("2"),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("3"),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("4"),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("5"),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("6"),
              //           ),
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Text("7"),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
