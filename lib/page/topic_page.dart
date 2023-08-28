import 'package:flutter/material.dart';

class TopicPage extends StatefulWidget {
  const TopicPage({super.key, required this.tid});

  final String tid;

  @override
  State<TopicPage> createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("data");
  }
}
