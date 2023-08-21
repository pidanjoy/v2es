import 'package:flutter/material.dart';
import 'package:v2es/widget/topic_list_widget.dart';

import '../widget/search_bar_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 0;
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // title: Text(widget.title),
      // ),
      body: SafeArea(
        child: Container(alignment: Alignment.center, child: initPageView()),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: initFloatingActionButton(),
      bottomNavigationBar: initBottomNavigationBar(),
    );
  }

  PageView initPageView() {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) {
        setState(() {
          _index = index;
        });
      },
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Column(
            children: [
              const MySearchBar(),
              Expanded(child: TopicList()),
            ],
          ),
        ),
        initPageViewItem("xx"),
        initPageViewItem("发布主题"),
        initPageViewItem("xx"),
        initPageViewItem("我的"),
      ],
    );
  }

  initPageViewItem(String s) {
    return Container(
      child: Text(s),
    );
  }

  Widget initFloatingActionButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(40)),
        child: FloatingActionButton(
          backgroundColor: _index == 2 ? Colors.yellow : Colors.grey,
          elevation: 10,
          onPressed: () {
            setState(() {
              _index = 2;
              _pageController.jumpToPage(_index);
            });
          },
          child: const Icon(Icons.android),
        ));
  }

  BottomNavigationBar initBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.lightGreen,
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
        _pageController.jumpToPage(_index);
      },
      items: [
        initBottomNavigationBarItem("首页", Icons.colorize, Icons.colorize),
        initBottomNavigationBarItem("记事本", Icons.cancel, Icons.cancel),
        initBottomNavigationBarItem("写作", Icons.cancel, Icons.cancel),
        initBottomNavigationBarItem("时间轴", Icons.android, Icons.android),
        initBottomNavigationBarItem("我的", Icons.ios_share, Icons.ios_share),
      ],
    );
  }

  initBottomNavigationBarItem(
      String title, IconData icon, IconData activeIcon) {
    return BottomNavigationBarItem(
      label: title,
      icon: Icon(
        icon,
        color: Colors.grey,
      ),
      activeIcon: Icon(
        activeIcon,
        color: Colors.lightGreen,
      ),
    );
  }
}
