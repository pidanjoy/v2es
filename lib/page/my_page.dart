import 'package:flutter/material.dart';
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
    return Column(
      children: [
        ImageLoader(
          imageUrl: 'https://crates.io/assets/cargo.png',
          width: 80,
          height: 80,
          circular: 40,
        ),
        Text(
          "Test nickname",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          "今日活跃度排名 4739",
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey,
          ),
        ),
        Text(
          "V2EX 第 513215 号会员，加入于 ${CommonUtil.formatTimeDifference(DateTime.parse('2020-10-17 17:37:44 +08:00'))}前",
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey,
          ),
        ),
        ElevatedButton(
          onPressed: () => {},
          child: Text("编辑个人资料"),
          style: ButtonStyle(elevation: MaterialStateProperty.all(1)),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Text("1"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("2"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("3"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("4"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("5"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("6"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("7"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
