import 'package:flutter/material.dart';
import 'package:v2es/config/app_config.dart';
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
  var _proxyPort = "";
  var _username = "";
  var _password = "";

  InputDecoration buildInputDecoration(String hintText) => InputDecoration(
        // border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
      );

  Container configTitle(String title) => Container(
        margin: const EdgeInsets.only(top: 10, bottom: 5),
        padding: const EdgeInsets.only(left: 5),
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 12,
          ),
        ),
      );

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
                    const Text("启用代理"),
                    SizedBox(
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
              configTitle('代理类型'),
              RadioListTile<String>(
                value: "HTTP",
                title: const Text("HTTP"),
                groupValue: _proxyType,
                onChanged: (value) {
                  setState(() {
                    _proxyType = value!;
                  });
                },
              ),
              RadioListTile<String>(
                value: "SOCKS5",
                title: const Text("SOCKS5"),
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
                child: const Text(
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
                onChanged: (value) {
                  setState(() {
                    _proxyHost = value;
                  });
                },
                decoration: buildInputDecoration('服务器'),
              ),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _proxyPort,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyPort.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _proxyPort = value;
                  });
                },
                decoration: buildInputDecoration('端口'),
              ),
              configTitle('认证信息（可选）'),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _username,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _username.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _username = value;
                  });
                },
                decoration: buildInputDecoration('用户名'),
              ),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _password,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _password.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                obscureText: true,
                decoration: buildInputDecoration('密码'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  debugPrint(
                      "proxy info => $_enableProxy,$_proxyType,$_proxyHost,$_proxyPort,$_username,$_password,");
                  AppConfig.gProxyParams.proxyEnable = _enableProxy;
                  AppConfig.gProxyParams.proxyType = _proxyType;
                  AppConfig.gProxyParams.proxyHost = _proxyHost;
                  AppConfig.gProxyParams.proxyPort = int.parse(_proxyPort);
                  AppConfig.gProxyParams.username = _username;
                  AppConfig.gProxyParams.password = _password;
                },
                child: const Text("保存"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
