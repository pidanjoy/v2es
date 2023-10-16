import 'package:flutter/material.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';

class NetworkErrorPage extends StatefulWidget {
  const NetworkErrorPage({super.key});

  @override
  State<NetworkErrorPage> createState() => _NetworkErrorPageState();
}

class _NetworkErrorPageState extends State<NetworkErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        size: CommonUtil.getScreenHeight(context) * 0.06,

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "无法连接到V2EX服务器",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "请检查网络设置或代理配置",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("重试"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("配置代理"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
