import 'package:flutter/material.dart';

import '../util/common_util.dart';

class TopicList extends StatefulWidget {
  const TopicList({super.key});

  @override
  State<TopicList> createState() => _TopicListState();
}

class _TopicListState extends State<TopicList> {
  final List<Article> articles = [
    Article(
        "想买点黄金，想问下 V 友们有哪些购买途径，哪种最好",
        "作者xx作者xx作者xx作者xx作者xx作者xx作者xx作者xx作者xx作者xx作者xx",
        "2023-08-21",
        "程序员",
        "User X"),
    Article("标题xxx", "作者xx", "2023-08-21", "Science", "User Y"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    Article("标题xxx", "作者xx", "2023-08-21", "Art", "User Z"),
    // Add more articles here
  ];

  bool _isLoadingMore = true;
  bool _noMoreItems = true;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        onRefresh: _refreshArticles,
        child: ListView.separated(
          itemCount: _isLoadingMore
              ? articles.length + 1
              : articles.length + (_noMoreItems ? 1 : 0),
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 0); // 分隔符（间距）
          },
          itemBuilder: (BuildContext context, int index) {
            if (_isLoadingMore && index == articles.length) {
              _startNoMoreItemsTimer();
              return _buildLoadingIndicator();
            }
            if (_noMoreItems && index == articles.length) {
              return _buildNoMoreItemsText();
            }
            return ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  height: 32,
                  width: 32,
                  color: Colors.grey,
                  child: Image.network("https://crates.io/assets/cargo.png"),
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
                    '10',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 2),
                  Flexible(
                    child: Text(
                      articles[index].title,
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
                      " • ${articles[index].tag} ",
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
                    CommonUtil.limitText(articles[index].author, 10),
                    style: const TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w600),
                  ),
                  Container(
                    width: 5,
                  ),
                  const Text(
                    '5分钟前',
                    style: TextStyle(fontSize: 10),
                  ),
                  Expanded(child: Container()),
                  const CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.grey,
                      child: Text(
                        "56",
                        style: TextStyle(
                          fontSize: 8,
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
      setState(() {
        _isLoadingMore = false;
        _noMoreItems = true;
        articles.add(Article("终了1", "Author C", "2023-08-19", "Art", "User Z"));
        articles.add(Article("终了2", "Author C", "2023-08-19", "Art", "User Z"));
        articles.add(Article("终了3", "Author C", "2023-08-19", "Art", "User Z"));
      });
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
