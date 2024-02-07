import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2es/constant/base_constant.dart';
import 'package:v2es/model/topic_model.dart';
import 'package:v2es/providers/data_provider.dart';
import 'package:v2es/service/home_service.dart';
import 'package:v2es/util/common_util.dart';

class MySearchBar extends StatefulWidget {
  const MySearchBar({super.key, required this.isFixed, this.onSearch});

  final Function(String)? onSearch;
  final bool isFixed;

  // final List<TopicHead>? topicHotList = [];

  @override
  State<MySearchBar> createState() => _MySearchBarState();
}

class _MySearchBarState extends State<MySearchBar>
    with SingleTickerProviderStateMixin {
  List<TopicHead> _textList = HomeService.topicHeadList;
  int currentIndex = 0;
  double opacity = 1.0;

  static final googleIcon = Image.asset("assets/images/google_icon_1x.png");
  static final v2exIcon = Image.asset("assets/images/icon-196.png");
  int _searchType = 0;
  Image _searchIcon = googleIcon;

  final TextEditingController _editController = TextEditingController();
  late final AnimationController _planController =
      AnimationController(duration: const Duration(seconds: 720), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    // if (null != widget.topicHotList) {
    // _textList = widget.topicHotList!;
    startTextAnimation();
    // }
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

  void switchSearchType() {
    setState(() {
      if (_searchType == 0) {
        _searchType = 1;
        _searchIcon = v2exIcon;
      } else {
        _searchType = 0;
        _searchIcon = googleIcon;
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
              RotationTransition(
                alignment: Alignment.center,
                turns: Tween(begin: 0.0, end: 360.0).animate(_planController),
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(2),
                  width: CommonUtil.getScreenWidth(context) * 0.12,
                  child: GestureDetector(
                    child: Image.asset("assets/images/v2ex_network.png"),
                    onTap: () => CommonUtil.routeTo(context, RouteName.plan),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 30,
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
                          child: GestureDetector(
                            onTap: () =>
                                CommonUtil.routeTo(context, RouteName.search),
                            child: Container(
                              alignment: Alignment.center,
                              height: 30,
                              child: AnimatedOpacity(
                                opacity: opacity,
                                duration: const Duration(seconds: 2),
                                child: Text(
                                  _textList[currentIndex].title,
                                  style: const TextStyle(fontSize: 12),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.0),
                          decoration: const BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20)),
                          ),
                          child: TextButton(
                            onPressed: () => Navigator.pushNamed(
                                context, '/topic',
                                arguments: _textList[currentIndex].href),
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: const Text(
                              '搜索',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        GestureDetector(
                          child: Container(
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            child: _searchIcon,
                          ),
                          onTap: () => switchSearchType(),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              hintText: " 请输入搜索内容",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 12,
                                  textBaseline: TextBaseline.alphabetic),
                            ),
                            cursorHeight: 25,
                            style: const TextStyle(
                                textBaseline: TextBaseline.ideographic),
                            controller: _editController,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(left: 1.0),
                          decoration: const BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(20),
                                right: Radius.circular(20)),
                          ),
                          child: TextButton(
                            onPressed: () => null != widget.onSearch
                                ? widget.onSearch!(_editController.text)
                                : () {},
                            style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                            ),
                            child: const Text(
                              '搜索',
                              style: TextStyle(
                                fontSize: 12.5,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
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
