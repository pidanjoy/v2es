import 'package:flutter/material.dart';
import 'package:v2es/page/my_page.dart';
import 'package:v2es/page/notebook_page.dart';
import 'package:v2es/page/timeline_page.dart';
import 'package:v2es/page/write_page.dart';
import 'package:v2es/widget/search_bar_widget.dart';
import 'package:v2es/widget/topic_list_widget.dart';

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
      floatingActionButton: initFloatingActionButton(),
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
          child: const Column(
            children: [
              MySearchBar(isFixed: true,),
              Expanded(child: TopicList()),
            ],
          ),
        ),
        const NotebookPage(),
        const WritePage(),
        const TimelinePage(),
        const MyPage(),
      ],
    );
  }

  Widget initFloatingActionButton() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(40)),
        child: FloatingActionButton(
          backgroundColor: _index == 2 ? Colors.deepPurple : Colors.white,
          elevation: 5,
          onPressed: () {
            setState(() {
              _index = 2;
              _pageController.jumpToPage(_index);
            });
          },
          child: _index == 2
              ? const Icon(
                  Icons.edit,
                  size: 32,
                  color: Colors.white,
                )
              : const Icon(
                  Icons.edit_calendar_rounded,
                  size: 32,
                  color: Colors.grey,
                ),
        ));
  }

  BottomNavigationBar initBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.deepPurple,
      type: BottomNavigationBarType.fixed,
      currentIndex: _index,
      onTap: (index) {
        setState(() {
          _index = index;
        });
        _pageController.jumpToPage(_index);
      },
      items: [
        initBottomNavigationBarItem(
            "首页", Icons.home_rounded, Icons.home_work_rounded),
        initBottomNavigationBarItem(
            "记事本", Icons.book_rounded, Icons.menu_book_rounded),
        initBottomNavigationBarItem(
            "写作", Icons.note_add_rounded, Icons.note_alt_rounded),
        initBottomNavigationBarItem(
            "时间轴", Icons.linear_scale, Icons.linear_scale_rounded),
        initBottomNavigationBarItem(
            "我的", Icons.android_rounded, Icons.insert_emoticon_rounded),
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
        color: Colors.deepPurple,
      ),
    );
  }
}
