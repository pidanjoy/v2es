import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/util/http_util.dart';
import 'package:v2es/widget/image_load_widget.dart';

import '../util/common_util.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key, required this.topicHeadList});

  final List<TopicHead> topicHeadList;

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> with AutomaticKeepAliveClientMixin {
  bool _isLoadingMore = true;
  bool _noMoreItems = true;
  List<TopicHead> _topicHeadList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _topicHeadList = widget.topicHeadList;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
        onRefresh: _refreshArticles,
        child: ListView.separated(
          itemCount: _isLoadingMore
              ? _topicHeadList.length + 1
              : _topicHeadList.length + (_noMoreItems ? 1 : 0),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(height: 0);
            // return const Divider();
          },
          itemBuilder: (BuildContext context, int index) {
            if (_isLoadingMore && index == _topicHeadList.length) {
              _startNoMoreItemsTimer();
              return _buildLoadingIndicator();
            }
            if (_noMoreItems && index == _topicHeadList.length) {
              return _buildNoMoreItemsText();
            }
            return ListTile(
              leading:
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 32,
                  width: 32,
                  color: Colors.grey,
                  child: ImageLoader(imageUrl: _topicHeadList[index].avatar ??
                      "https://crates.io/assets/cargo.png",),
                  // FutureBuilder(
                  //   future: HttpUtil.loadImage(_topicHeadList[index].avatar ??
                  //        "https://crates.io/assets/cargo.png"),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.connectionState == ConnectionState.waiting) {
                  //       return const CircularProgressIndicator();
                  //     } else if (snapshot.hasError) {
                  //       return Text("Error: ${snapshot.error}");
                  //     } else {
                  //       return Image.memory(snapshot.data);
                  //     }
                  //   },
                  // ),
                ),
              ),
              title: Row(
                children: [
                  const Icon(
                    Icons.arrow_drop_up,
                    color: Colors.green,
                    size: 10,
                  ),
                  const Text(
                    '1',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: Text(
                      _topicHeadList[index].title,
                      style: const TextStyle(fontSize: 12.5),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(30, 30, 30, 0.35),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      " • ${_topicHeadList[index].nodeTitle} ",
                      style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    width: 5,
                  ),
                  // Text(
                  //   articles[index].lastReplyPerson,
                  //   style: const TextStyle(fontSize: 10),
                  // ),
                  // Container(
                  //   width: 5,
                  // ),
                  Text(
                    CommonUtil.limitText(
                        _topicHeadList[index].authorName ?? "", 10),
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 5,
                  ),
                  const Text(
                    '50分钟前',
                    style: TextStyle(fontSize: 10),
                  ),
                  Expanded(child: Container()),
                  CircleAvatar(
                      radius: 8.5,
                      backgroundColor: Colors.grey,
                      child: Text(
                        _topicHeadList[index].replyQty?.toString() ?? "-",
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
              onTap: () {
                // Handle article tap
              },
            );
          },
        ));
  }

  Future<void> _refreshArticles() async {
    await Future.delayed(const Duration(seconds: 2));
  }

  Widget _buildLoadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNoMoreItemsText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          '没有更多内容',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ),
    );
  }

  void _startNoMoreItemsTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
          _noMoreItems = true;
          _topicHeadList.add(TopicHead("终了1", "Author C"));
          _topicHeadList.add(TopicHead("终了2", "Author C"));
          _topicHeadList.add(TopicHead("终了3", "Author C"));
        });
      }
    });
  }
}

class Article {
  final String title;
  final String author;
  final String date;
  final String tag;
  final String lastReplyPerson;

  Article(this.title, this.author, this.date, this.tag, this.lastReplyPerson);
}
