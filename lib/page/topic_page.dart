import 'package:flutter/material.dart';
import 'package:v2es/api/topic_api.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/html_to_widget.dart';
import 'package:v2es/widget/image_load_widget.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';
import 'package:v2es/widget/text_tag_widget.dart';
import 'package:v2es/widget/topic_loading_widget.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key, required this.uri});

  final String uri;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  void initState() {
    super.initState();
  }

  Future<Topic?> loadTopic() async {
    return await TopicApi.getTopicDetail(widget.uri);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        size: CommonUtil.getScreenHeight(context) * 0.06,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search_rounded,
              size: 18,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(
              Icons.ac_unit_rounded,
              size: 18,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          IconButton(
            icon: const Icon(
              Icons.add_rounded,
              size: 22,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ]
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: loadTopic(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const TopicLoadingWidget();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              List<Widget> titleArea = [];
              // 0.author
              titleArea.add(Someone(
                avatar: snapshot.data!.avatar,
                authorName: snapshot.data!.authorName,
                authorHref: snapshot.data!.authorHref,
                releaseTime: snapshot.data!.releaseTime!,
              ));
              // 1.Title
              titleArea.add(Text(
                snapshot.data!.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16.0),
              ));
              // 2.Node
              if (null != snapshot.data!.nodeTitle) {
                titleArea.add(TextTag(
                  text: snapshot.data!.nodeTitle!,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  fontSize: 12.0,
                ));
              }
              // 3.content
              titleArea.add(HtmlToWidget(htmlContext: snapshot.data!.context));
              // 4.postscript
              if (null != snapshot.data!.postscript) {
                titleArea.add(const Divider());
                titleArea
                    .add(HtmlToWidget(htmlContext: snapshot.data!.postscript!));
              }

              return ListView(
                children: [
                  // title
                  Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: titleArea,
                    ),
                  ),
                  Container(
                    color: const Color.fromRGBO(225, 225, 225, 1.0),
                    height: 10,
                  ),
                  // reply
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    itemCount: snapshot.data!.replies!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Someone(
                                  avatar: snapshot.data!.replies![index].avatar,
                                  authorName:
                                      snapshot.data!.replies![index].replyName,
                                  authorHref:
                                      snapshot.data!.replies![index].replyHref,
                                  releaseTime:
                                      snapshot.data!.replies![index].replyTime!,
                                  otherWidget: Row(
                                    children: [
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.thumb_up_alt_rounded,
                                          color: Colors.grey,
                                          size: 14,
                                        ),
                                        onTap: () => {},
                                      ),
                                      const SizedBox(width: 3),
                                      Text(
                                        snapshot.data!.replies![index]
                                                    .thanksCount! !=
                                                0
                                            ? "${snapshot.data!.replies![index].thanksCount!}"
                                            : "",
                                        style: const TextStyle(
                                            color: Colors.grey, fontSize: 12.0),
                                      ),
                                      const SizedBox(width: 15),
                                      GestureDetector(
                                        child: const Icon(
                                          Icons.reply,
                                          color: Colors.grey,
                                          size: 16,
                                        ),
                                        onTap: () => {},
                                      ),
                                      const SizedBox(width: 15),
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          padding: const EdgeInsets.all(0),
                                          color: const Color.fromRGBO(
                                              160, 160, 160, 1.0),
                                          width: 15,
                                          height: 15,
                                          alignment: Alignment.center,
                                          child: Text(
                                            "${snapshot.data!.replies![index].level!}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 8.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                HtmlToWidget(
                                  htmlContext:
                                      snapshot.data!.replies![index].context,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            color: const Color.fromRGBO(225, 225, 225, 1.0),
                            height: 5,
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

class Someone extends StatelessWidget {
  final String avatar;
  final String authorName;
  final String authorHref;
  final DateTime releaseTime;

  final Widget? otherWidget;

  const Someone(
      {super.key,
      required this.avatar,
      required this.authorName,
      required this.authorHref,
      required this.releaseTime,
      this.otherWidget});

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Row(
        children: [
          ImageLoader(
            imageUrl: avatar,
            width: 25.0,
            circular: 20.0,
          ),
          const SizedBox(width: 5.0),
          GestureDetector(
            child: Text(authorName),
            onTap: () => {
              debugPrint(authorHref),
            },
          ),
          Text(
            " • ${CommonUtil.formatTimeDifference(releaseTime)}",
            style: const TextStyle(color: Colors.grey, fontSize: 12.0),
          ),
        ],
      )
    ];
    if (null != otherWidget) {
      list.add(otherWidget!);
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: list,
      ),
    );
  }
}
