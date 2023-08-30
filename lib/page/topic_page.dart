import 'package:flutter/material.dart';
import 'package:v2es/api/topic_api.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/widget/topic_loading_widget.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key, required this.uri});

  final String uri;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  bool _isLoading = true;
  late Topic topic;

  @override
  void initState() {
    super.initState();
    loadTopic();
  }

  Future<void> loadTopic() async {
    Topic topic = await TopicApi.getTopicDetail(widget.uri);
    setState(() {
      topic = topic;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Offstage(
              offstage: !_isLoading,
              child: const TopicLoadingWidget(),
            ),
            Offstage(
              offstage: _isLoading,
              child: Text("加载完成"),
            )
          ],
        ),
      ),
    );
  }
}
