import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2es/api/node_api.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/providers/data_provider.dart';
import 'package:v2es/util/common_util.dart';

class MyTabBar extends StatefulWidget {
  const MyTabBar({
    super.key,
    // required this.tabList,
    // required this.tabNodes,
  });

  // final List<NodeTab> tabList;
  // final List<String> tabNodes;

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  // bool _isExpand = false;

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Stack(
        children: [
          SizedBox(
              width: CommonUtil.getScreenWidth(context) - 40,
              child: Consumer(builder: (context, ref, _) {
                final homeData = ref.watch(homeDataProviderProvider);
                var tabList = homeData.value?.tabList ?? [];
                var tabNodes = [];

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount:
                      // !_isExpand ? widget.tabList.length : widget.tabNodes.length,
                      tabList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return
                        // !_isExpand
                        //   ?
                        Container(
                      margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                      width: 60,
                      child: Consumer(
                        builder: (context, ref, _) {
                          final homeData = ref.watch(homeDataProviderProvider);

                          return TextButton(
                            onPressed: () {
                              setState(() {
                                debugPrint("1111$_current,$index");
                                if (_current != index) {
                                  // ref.read(tabProvider).href =
                                  //     tabList[index].href;
                                  // ref.read(tabProvider).name =
                                  //     tabList[index].name;
                                  debugPrint("xxx");
                                  ref.refresh(homeDataProviderProvider);
                                }
                                _current = index;
                              });
                            },
                            style: ButtonStyle(
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(1.0))),
                            child: Text(
                              tabList[index].name,
                              style: index != _current
                                  ? const TextStyle(
                                      fontSize: 14, color: Colors.blueGrey)
                                  : const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w800),
                            ),
                          );
                        },
                      ),
                    );
                    // : Container(
                    //     margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    //     child: TextButton(
                    //       onPressed: () {},
                    //       style: ButtonStyle(
                    //         padding: MaterialStateProperty.all(
                    //             const EdgeInsets.all(1.0)),
                    //       ),
                    //       child: Text(
                    //         widget.tabNodes[index],
                    //         style: const TextStyle(
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.normal,
                    //             color: Colors.grey),
                    //       ),
                    //     ),
                    //   );
                  },
                );
              })),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     Container(
          //       width: 1.0,
          //       height: 40.0,
          //       margin: const EdgeInsets.only(top: 5),
          //       decoration: const BoxDecoration(
          //         color: Colors.white,
          //         boxShadow: [
          //           BoxShadow(
          //             color: Colors.grey,
          //             offset: Offset(-3, 0),
          //             blurRadius: 3.0,
          //           ),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       width: 35,
          //       margin: const EdgeInsets.only(top: 5),
          //       child: GestureDetector(
          //         child: Icon(
          //           // _isExpand
          //           //     ?
          //           Icons.notes_rounded,
          //               // : Icons.settings_ethernet_rounded,
          //           color: const Color.fromRGBO(0, 0, 0, 0.6),
          //           size: 20,
          //         ),
          //         onTap: () {
          //           setState(() {
          //             // _isExpand = !_isExpand;
          //           });
          //         },
          //       ),
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
