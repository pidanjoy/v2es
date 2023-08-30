import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/widget/image_load_widget.dart';
import 'package:v2es/widget/keep_alive_wrapper.dart';

import '../util/common_util.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key, required this.topicHeadList});

  final List<TopicHead> topicHeadList;

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  bool _isLoadingMore = true;
  bool _noMoreItems = true;
  List<TopicHead> _topicHeadList = [];
  late HomeData homeDataProvider;

  @override
  void initState() {
    super.initState();
    _topicHeadList = widget.topicHeadList;
  }

  @override
  Widget build(BuildContext context) {
    homeDataProvider = Provider.of<HomeData>(context);
    return RefreshIndicator(
        onRefresh: _refreshTopics,
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
            return KeepAliveWrapper(
              keepAlive: true,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    height: 32,
                    width: 32,
                    color: Colors.grey,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1),
                      child: ImageLoader(
                        imageUrl: _topicHeadList[index].avatar ??
                            "https://crates.io/assets/cargo.png",
                      ),
                    ),
                  ),
                ),
                title: Row(
                  children: [
                    Flexible(
                      child: Text(
                        _topicHeadList[index].title,
                        style: const TextStyle(
                          fontSize: 12.5,
                        ),
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
                    Row(
                      children: null != _topicHeadList[index].rankUp &&
                              _topicHeadList[index].rankUp != 0
                          ? [
                              const Icon(
                                Icons.arrow_drop_up,
                                color: Colors.green,
                                size: 16,
                              ),
                              Text(
                                _topicHeadList[index].rankUp.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.green,
                                ),
                              ),
                              const SizedBox(width: 5),
                            ]
                          : [],
                    ),
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
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      CommonUtil.limitText(
                          _topicHeadList[index].authorName ?? "", 15),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(77, 77, 77, 1.0),
                          fontWeight: FontWeight.w500),
                    ),
                    Container(
                      width: 5,
                    ),
                    Expanded(child: Container()),
                    Text(
                      null != _topicHeadList[index].lastReplyTime
                          ? CommonUtil.formatTimeDifference(
                              _topicHeadList[index].lastReplyTime!)
                          : "刚刚",
                      style: const TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    CircleAvatar(
                      radius: 8.5,
                      backgroundColor: Colors.grey,
                      child: Text(
                        _topicHeadList[index].replyQty.toString() ?? "-",
                        style: const TextStyle(
                          fontSize: 9,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  // Handle article tap
                },
              ),
            );
          },
        ));
  }

  Future<void> _refreshTopics() async {
    HomeData data = await NodeApi.getHomeData();
    await homeDataProvider.saveData(
        tabList: data.tabList,
        topicHeadList: data.topicHeadList,
        topicHotList: data.topicHotList);
  }

  Widget _buildLoadingIndicator() {
    return Consumer<HomeData>(
      builder: (context, HomeData homeDataProvider, child) => const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget _buildNoMoreItemsText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          '没有更多内容了',
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
          // _topicHeadList.add(TopicHead("下一页新主题...", "Author X"));
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
