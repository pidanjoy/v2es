import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/image_load_widget.dart';

class HtmlToWidget extends StatefulWidget {
  final String htmlContext;

  const HtmlToWidget({super.key, required this.htmlContext});

  @override
  State<HtmlToWidget> createState() => _HtmlToWidgetState();
}

class _HtmlToWidgetState extends State<HtmlToWidget> {
  @override
  Widget build(BuildContext context) {
    fixUrl(String href) {
      if (!href.contains("https") && !href.contains("http")) {
        href = "https:$href";
      }
      if (href.startsWith("/")) {
        href = ApiEndpoints.baseUrl + href;
      }
      return href;
    }

    return HtmlWidget(
      widget.htmlContext,
      customStylesBuilder: (element) {
        if (element.classes.contains('foo')) {
          return {'color': 'red'};
        }
        return null;
      },
      customWidgetBuilder: (element) {
        if (element.localName == "img") {
          var imgSrc = element.attributes['src'];
          if (null != imgSrc) {
            imgSrc = fixUrl(imgSrc);
            return ImageLoader(
              imageUrl: imgSrc,
              width: CommonUtil.getScreenWidth(context),
              enableEnlarge: true,
            );
          }
        }
        return null;
      },
      onErrorBuilder: (context, element, error) =>
          Text('$element error: $error'),
      onLoadingBuilder: (context, element, loadingProgress) =>
          const CircularProgressIndicator(),
      onTapUrl: (url) async {
        try {
          return await launchUrl(
            Uri.parse(fixUrl(url)),
            mode: LaunchMode.externalApplication,
          );
        } catch (_) {
          Clipboard.setData(ClipboardData(text: url));
          showToast(
            '调用浏览器失败，已复制链接',
            context: context,
            animation: StyledToastAnimation.scale,
          );
          return true;
        }
      },
    );
  }
}
