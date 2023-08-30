import 'package:flutter/material.dart';
import 'package:v2es/model/topic_model.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar(
      {super.key, required this.isFixed, this.onSearch, this.topicHotList});

  final Function(String)? onSearch;
  final bool isFixed;
  final List<TopicHead>? topicHotList;

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar> {
  List<TopicHead> _textList = [];
  int currentIndex = 0;
  double opacity = 1.0;

  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (null != widget.topicHotList) {
      _textList = widget.topicHotList!;
      startTextAnimation();
    }
  }

  void startTextAnimation() {
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          opacity = 0.5;
        });
      }
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % _textList.length;
          opacity = 1.0;
        });
        startTextAnimation();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isFixed
        ? Row(
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
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    color: const Color.fromARGB(30, 30, 30, 30),
                    child: AnimatedOpacity(
                      opacity: opacity,
                      duration: const Duration(seconds: 2),
                      child: Text(
                        _textList[currentIndex].title,
                        style:
                            const TextStyle(fontSize: 12.5, color: Colors.grey),
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
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5, bottom: 2),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Expanded(
                child: Container(
                  height: 36,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.grey),
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.only(right: 5, top: 5, bottom: 2),
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    decoration: const BoxDecoration(),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: "Google site:v2ex.com/t",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  textBaseline: TextBaseline.alphabetic),
                            ),
                            cursorHeight: 22,
                            style: const TextStyle(
                                textBaseline: TextBaseline.ideographic),
                            controller: _controller,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.0),
                          decoration: const BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20)),
                          ),
                          child: TextButton(
                            child: const Text(
                              '搜索',
                              style: TextStyle(
                                  fontSize: 11, fontWeight: FontWeight.w800),
                            ),
                            onPressed: () => null != widget.onSearch
                                ? widget.onSearch!(_controller.text)
                                : () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
