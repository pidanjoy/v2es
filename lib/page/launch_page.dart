import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/util/common_util.dart';

class LaunchPage extends StatefulWidget {
  const LaunchPage({super.key});

  @override
  State<LaunchPage> createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  bool _isLoading = true;
  bool _isError = false;

  Future<void> loadData(HomeData homeDataProvider) async {
    if (_isLoading) {
      HomeData homeData = await NodeApi.getHomeData();
      setState(() {
        _isLoading = false;
      });
      if (!homeData.isEmpty()) {
        homeDataProvider.updateProvider(homeData);
        nextPage();
      } else {
        _isError = true;
      }
    } else if (!_isError) {
      nextPage();
    }
  }

  void nextPage() {
    CommonUtil.routeTo(context, RouteName.home);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeDataProvider = Provider.of<HomeData>(context);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      loadData(homeDataProvider);
    });
    return SafeArea(
      child: Scaffold(
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
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 10, right: 5),
                alignment: Alignment.centerLeft,
                child: const Text(
                  "V2EX创意工作者们的社区\nWorld is powered by solitude.",
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
              _isLoading
                  ? Image.asset(
                      "assets/images/nyan-cat.gif",
                      width: 100,
                    )
                  : Column(
                      children: _isError
                          ? [
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
                                        _isLoading = true;
                                    }),
                                    child: const Text("重试"),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () => CommonUtil.routeTo(
                                        context, RouteName.proxyConfig),
                                    child: const Text("配置代理"),
                                  ),
                                ],
                              ),
                            ]
                          : [],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
