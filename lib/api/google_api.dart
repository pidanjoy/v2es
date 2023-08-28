import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html_parse;
import 'package:v2es/model/google_model.dart';
import 'package:v2es/util/http_util.dart';

class GoogleApi {
  static Future<List<GoogleSearchTopic>> search(String searchKeywords) async {
    Map<String, dynamic>? headers = {
      "User-Agent":
          "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/116.0.0.0 Safari/537.36"
    };
    HttpUtil.setHeaders(headers);

    var keywords = Uri.encodeFull(searchKeywords);
    var start = 0;
    var query = "site%3Av2ex.com%2Ft+$keywords";
    Response response = await HttpUtil.get(
        'https://www.google.com/search?q=$query&start=$start');
    var document = html_parse.parse(response.data);

    List<GoogleSearchTopic> list = [];
    var eleContentChildren = document.getElementById('rso')?.children;
    if (null != eleContentChildren) {
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
    }
    return list;
  }
}
