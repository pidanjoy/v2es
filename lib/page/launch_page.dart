import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/util/common_util.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  bool isLoading = true;

  Future<void> loadData(HomeData homeDataProvider) async {
    if (isLoading) {
      if (homeDataProvider.tabList.isEmpty ||
          homeDataProvider.topicHeadList.isEmpty ||
          homeDataProvider.topicHotList.isEmpty) {
        HomeData homeData = await NodeApi.getHomeData();
        debugPrint("main >>> ${jsonEncode(homeData.topicHeadList)}");
        homeDataProvider = homeData;
        setState(() {
          isLoading = false;
        });
        debugPrint("AAA $isLoading");
      } else {
        CommonUtil.routeTo(context, RouteName.home);
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeData>(context);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      loadData(homeDataProvider);
    });
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        color: const Color.fromRGBO(243, 243, 243, 1.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                "assets/images/v2es_logo_startup.png",
                width: 110,
                height: 55,
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 15, left: 10, right: 5),
              alignment: Alignment.centerLeft,
              child: const Text(
                "创意工作者们的社区\nWorld is powered by solitude",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Container(
              decoration: ShapeDecoration(
                color: const Color(0xFF001524),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23),
                ),
                shadows: const [
                  BoxShadow(
                    color: Color(0x4C000000),
                    blurRadius: 8,
                    offset: Offset(8, 8),
                    spreadRadius: 0,
                  )
                ],
              ),
              margin: const EdgeInsets.only(
                  left: 10, top: 5, right: 20, bottom: 10),
              child: Image.asset(
                "assets/images/v2es_code_startup.png",
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? Image.asset(
                    "assets/images/nyan-cat.gif",
                    width: 100,
                  )
                : Column(
                    children: [
                      Image.asset(
                        "assets/images/nyan-cat_0.png",
                        width: 100,
                      ),
                      const Text(
                        "无法连接到V2EX服务器",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => setState(() {
                              isLoading = true;
                            }),
                            child: const Text("重试"),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () =>
                                CommonUtil.routeTo(context, RouteName.setting),
                            child: const Text("配置代理"),
                          ),
                        ],
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
