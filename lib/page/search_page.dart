import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/http_util.dart';
import 'package:v2es/widget/search_bar_widget.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:webview_flutter/webview_flutter.dart';

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
    debugPrint("[onSearch]$text");
    if (text.isEmpty) {
      return;
    }
    Map<String, dynamic>? headers = {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36"
    };
    HttpUtil.setHeaders(headers);

    var keywords = Uri.encodeFull(text);
    var start = 0;
    var query = "site%3Av2ex.com%2Ft+$keywords";
    Response response = await HttpUtil.get(
        'https://www.google.com/search?q=$query&start=$start');
    var document = html_parse.parse(response.data);

    var eleContentChildren = document.getElementById('rso')?.children;
    if (null != eleContentChildren) {
      List<GoogleSearchTopic> list = [];

      for (var content in eleContentChildren) {
        var link = content.querySelector('a[href^="https://www.v2ex.com/t/"]');
        String? href = link?.attributes['href'];
        String? title = link?.querySelector('h3')?.innerHtml;
        var subtitle =
            content.querySelector('div[style="-webkit-line-clamp:2"]')?.text;
        if (null != href && null != title && null != subtitle) {
          list.add(GoogleSearchTopic(title, href, subtitle));
        }
      }
      setState(() {
        _topicSearchList.addAll(list);
      });
    }
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
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      _topicSearchList[index].isClick = true;
                    });
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
