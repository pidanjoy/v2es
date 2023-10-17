import 'package:flutter/material.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';

import '../util/common_util.dart';

class ProxyConfigPage extends StatefulWidget {
  const ProxyConfigPage({super.key});

  @override
  State<ProxyConfigPage> createState() => _ProxyConfigPageState();
}

class _ProxyConfigPageState extends State<ProxyConfigPage> {
  var _enableProxy = false;
  var _proxyType = "HTTP";
  var _proxyHost = "";
  var _proxyPort = 0;
  var _username = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          size: CommonUtil.getScreenHeight(context) * 0.06,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "代理配置",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                color: Colors.white,
                height: CommonUtil.getScreenHeight(context) * 0.06,
                margin: const EdgeInsets.only(top: 2, bottom: 2),
                padding: const EdgeInsets.only(left: 5, right: 7),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("启用代理"),
                    Container(
                      height: 10,
                      child: Switch(
                          value: _enableProxy,
                          onChanged: (value) {
                            setState(() {
                              _enableProxy = value;
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
                  "代理类型",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              RadioListTile<String>(
                value: "HTTP",
                title: Text("HTTP"),
                groupValue: _proxyType,
                onChanged: (value) {
                  setState(() {
                    _proxyType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                value: "SOCKS5",
                title: Text("SOCKS5"),
                groupValue: _proxyType,
                onChanged: (value) {
                  setState(() {
                    _proxyType = value!;
                  });
                },
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "连接",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _proxyHost,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyHost.length,
                      ),
                    ),
                  ),
                ),
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: '服务器',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: '端口',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 5),
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  "认证信息（可选）",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: '用户名',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  // border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.grey[200],
                  hintText: '密码',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  debugPrint("proxy info => $_proxyHost");
                },
                child: Text("保存"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
