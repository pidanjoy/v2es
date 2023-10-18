import 'package:flutter/material.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/model/config_model.dart';
import 'package:v2es/util/http_util.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';

import '../util/common_util.dart';

class ProxyConfigPage extends StatefulWidget {
  const ProxyConfigPage({super.key});

  @override
  State<ProxyConfigPage> createState() => _ProxyConfigPageState();
}

class _ProxyConfigPageState extends State<ProxyConfigPage> {
  final _proxyParams = ProxyParams.fromJson(AppConfig.gProxyParams.toJson());

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
                          value: _proxyParams.proxyEnable,
                          onChanged: (value) {
                            setState(() {
                              _proxyParams.proxyEnable = value;
                            });
                          }),
                    ),
                  ],
                ),
              ),
              configTitle('代理类型'),
              RadioListTile<String>(
                value: "http",
                title: const Text("HTTP"),
                groupValue: _proxyParams.proxyType,
                onChanged: (value) {
                  setState(() {
                    _proxyParams.proxyType = value!;
                  });
                },
              ),
              // RadioListTile<String>(
              //   value: "socks5",
              //   title: const Text("SOCKS5"),
              //   groupValue: _proxyParams.proxyType,
              //   onChanged: (value) {
              //     setState(() {
              //       _proxyParams.proxyType = value!;
              //     });
              //   },
              // ),
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
                    text: _proxyParams.proxyHost,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyParams.proxyHost.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _proxyParams.proxyHost = value;
                  });
                },
                decoration: buildInputDecoration('服务器'),
              ),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _proxyParams.proxyPort.toString(),
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyParams.proxyPort.toString().length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _proxyParams.proxyPort = int.parse(value);
                  });
                },
                decoration: buildInputDecoration('端口'),
              ),
              configTitle('认证信息（可选）'),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _proxyParams.username,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyParams.username.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _proxyParams.username = value;
                  });
                },
                decoration: buildInputDecoration('用户名'),
              ),
              TextField(
                controller: TextEditingController.fromValue(
                  TextEditingValue(
                    text: _proxyParams.password,
                    selection: TextSelection.fromPosition(
                      TextPosition(
                        affinity: TextAffinity.downstream,
                        offset: _proxyParams.password.length,
                      ),
                    ),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    _proxyParams.password = value;
                  });
                },
                obscureText: true,
                decoration: buildInputDecoration('密码'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  AppConfig.gProxyParams = _proxyParams;
                  debugPrint(AppConfig.gProxyParams.proxyHost);
                  HttpUtil.nirvana();
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
