import 'package:flutter/material.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key});

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<String> textList = ["请输入搜索内容1", "请输入搜索内容2", "请输入搜索内容3"];
  int currentIndex = 0;
  double opacity = 1.0;

  @override
  void initState() {
    super.initState();
    startTextAnimation();
  }

  void startTextAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        opacity = 0.5;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        currentIndex = (currentIndex + 1) % textList.length;
        opacity = 1.0;
      });
      startTextAnimation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 30,
            color: const Color.fromARGB(60, 30, 30, 30),
            child: const Center(child: Text('节点')),
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            alignment: Alignment.center,
            height: 30,
            color: const Color.fromARGB(30, 30, 30, 30),
            child: GestureDetector(
              onTap: () => {},
              child: AnimatedOpacity(
                opacity: opacity,
                duration: const Duration(seconds: 2),
                child: Text(
                  textList[currentIndex],
                  style: const TextStyle(fontSize: 12.5, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 30,
            color: const Color.fromARGB(60, 30, 30, 30),
            child: const Center(child: Text('搜索')),
          ),
        ),
      ],
    );
  }
}
