import 'package:flutter/material.dart';
import 'package:url_launcher/link.dart';
import 'package:v2es/api/topic_api.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/html_to_widget.dart';
import 'package:v2es/widget/image_load_widget.dart';
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
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(CommonUtil.getScreenHeight(context) * 0.06),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(35, 29, 40, 1.0),
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'V2EX',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
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
          ],
        ),
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
              titleArea.add(Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ImageLoader(
                        imageUrl: snapshot.data!.avatar,
                        width: 25.0,
                        circular: 20.0,
                      ),
                      const SizedBox(width: 5.0),
                      GestureDetector(
                        child: Text(snapshot.data!.authorName),
                        onTap: () => {
                          debugPrint(snapshot.data!.authorHref),
                        },
                      ),
                      Text(
                        " • ${CommonUtil.formatTimeDifference(snapshot.data!.releaseTime!)}",
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  )));
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
                titleArea
                    .add(HtmlToWidget(htmlContext: snapshot.data!.postscript!));
              }

              return Container(
                padding: const EdgeInsets.all(5),
                child: ListView(
                  children: [
                    // title
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: titleArea,
                    ),
                    // reply
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: snapshot.data!.replies!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            HtmlToWidget(
                              htmlContext:
                                  snapshot.data!.replies![index].context,
                            ),
                            const Divider(),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
