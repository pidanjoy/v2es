import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:v2es/api/google_api.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/google_model.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/search_bar_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // late WebViewController? _webViewController;

  final List<GoogleSearchTopic> _topicSearchList = [];

  @override
  void initState() {
    // _webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
    //   ..setBackgroundColor(const Color(0x00000000))
    //   ..setNavigationDelegate(
    //     NavigationDelegate(
    //       onProgress: (int progress) {
    //         // Update loading bar.
    //       },
    //       onPageStarted: (String url) {},
    //       onPageFinished: (String url) {},
    //       onWebResourceError: (WebResourceError error) {},
    //       onNavigationRequest: (NavigationRequest request) {
    //         if (request.url.startsWith('https://www.v2ex.com/t')) {
    //           return NavigationDecision.prevent;
    //         }
    //         return NavigationDecision.navigate;
    //       },
    //     ),
    //   )
    //   ..loadRequest(Uri.parse('https://www.google.com/search?q=site%3Av2ex.com%2Ft+%E6%B5%8B%E8%AF%95'));
    super.initState();
  }

  void onSearch(String text) async {
    EasyLoading.show();
    debugPrint("[onSearch]$text");
    if (text.isEmpty) {
      EasyLoading.dismiss();
      return;
    }
    List<GoogleSearchTopic> list = await GoogleApi.search(text);
    setState(() {
      _topicSearchList.clear();
      _topicSearchList.addAll(list);
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MySearchBar(
              isFixed: false,
              onSearch: onSearch,
            ),
            Expanded(
              // child: WebViewWidget(controller: _webViewController!),
              child: ListView.builder(
                itemCount: _topicSearchList.length,
                itemBuilder: (context, index) =>
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _topicSearchList[index].isClick = true;
                        });
                        debugPrint("G:${_topicSearchList[index].href}");
                        CommonUtil.routeTo(context, RouteName.topic,
                            arguments: _topicSearchList[index].href);
                      },
                      child: ListTile(
                        title: Text(
                          _topicSearchList[index].title,
                          style: TextStyle(
                            color: _topicSearchList[index].isClick
                                ? const Color.fromRGBO(104, 29, 128, 1)
                                : Colors.blueAccent,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          _topicSearchList[index].subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
