import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 30,
            color: Colors.red,
            child: Center(child: Text('节点')),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            height: 30,
            color: Colors.green,
            child: Center(child: Text('输入框')),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 30,
            color: Colors.blue,
            child: Center(child: Text('搜索')),
          ),
        ),
      ],
    );
  }
}
