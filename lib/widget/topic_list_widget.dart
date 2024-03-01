import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:provider/provider.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/cache_model.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/providers/data_provider.dart';
import 'package:v2es/service/home_service.dart';
import 'package:v2es/widget/image_load_widget.dart';
import 'package:v2es/widget/keep_alive_wrapper.dart';
import 'package:v2es/widget/text_tag_widget.dart';

import '../util/common_util.dart';

class TopicList extends ConsumerStatefulWidget {
  const TopicList({super.key});

  @override
  ConsumerState<TopicList> createState() => _TopicListState();
}

class _TopicListState extends ConsumerState<TopicList> {
  bool _isLoadingMore = true;
  bool _noMoreItems = true;


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final homeData = ref.watch(homeDataProviderProvider);
      return homeData.when(
        loading: () => const CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
        data: (data) {
          var topicHeadList = data.isEmpty() ? [] : data.topicHeadList;
          return RefreshIndicator(
            onRefresh: () async {
              HomeService.refreshHomeData(ref);
            },
            child: ListView.separated(
                itemCount: _isLoadingMore
                    ? topicHeadList.length + 1
                    : topicHeadList.length + (_noMoreItems ? 1 : 0),
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 0);
                  // return const Divider();
                },
                itemBuilder: (BuildContext context, int index) {
                  if (_isLoadingMore && index == topicHeadList.length) {
                    _startNoMoreItemsTimer();
                    return _buildLoadingIndicator();
                  }
                  if (_noMoreItems && index == topicHeadList.length) {
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
                              imageUrl: topicHeadList[index].avatar ??
                                  "https://crates.io/assets/cargo.png",
                            ),
                          ),
                        ),
                      ),
                      title: Row(
                        children: [
                          Flexible(
                            child: Text(
                              topicHeadList[index].title,
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
                            children: null != topicHeadList[index].rankUp &&
                                    topicHeadList[index].rankUp != 0
                                ? [
                                    const Icon(
                                      Icons.arrow_drop_up,
                                      color: Colors.green,
                                      size: 16,
                                    ),
                                    Text(
                                      topicHeadList[index].rankUp.toString(),
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
                          TextTag(
                            text: topicHeadList[index].nodeTitle!,
                            margin: const EdgeInsets.fromLTRB(0, 2, 0, 0),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            CommonUtil.limitText(
                                topicHeadList[index].authorName ?? "", 15),
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
                            null != topicHeadList[index].lastReplyTime
                                ? CommonUtil.formatTimeDifference(
                                    topicHeadList[index].lastReplyTime!)
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
                              topicHeadList[index].replyQty.toString() ?? "-",
                              style: const TextStyle(
                                fontSize: 9,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () => CommonUtil.routeTo(context, RouteName.topic,
                          arguments: topicHeadList[index].href),
                    ),
                  );
                }),
          );
        },
      );
    });
  }

  Widget _buildLoadingIndicator() {
    EasyLoading.show(
      status: '加载中',
    );
    Future.delayed(const Duration(seconds: 2), () {
      EasyLoading.dismiss();
    });
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _buildNoMoreItemsText() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 16, 16, 30),
      child: Center(
        child: Text(
          '没有更多内容了',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12.0,
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
