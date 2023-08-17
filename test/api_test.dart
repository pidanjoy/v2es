import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:v2es/api/login_api.dart';
import 'package:v2es/api/node_api.dart';

import 'package:v2es/model/login_model.dart';

void main() {
  test("api test", () async {
    var hearders = {
      "User-Agent":
          "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
      "Origin": "https://www.v2ex.com",
      "Accept": "*/*",
      "Connection": "keep-alive",
      "Referer": "https://www.v2ex.com/signin",
      "Cookie":
          'A2="2|1:0|10:1691649305|2:A2|48:MWE2NWU1MTUtNjJjZS00NjVjLThhY2YtZTYzMzhhY2ZjOTgy|82ab520bbde859cb632e72ffbf027a3c2ad3391654a678e04c13f16d378876b9"; Domain=.v2ex.com; expires=Wed, 08 Nov 2023 06:35:05 GMT; httponly; Path=/;V2EX_LANG=zhcn; Path=/',
    };

    LoginKey? loginKey = await LoginApi.getLoginKey();
    assert(loginKey?.cookie != null);

    List<String> topics = await NodeApi.getHomeTopics(hearders);
    debugPrint(topics.toString());
  });
}
