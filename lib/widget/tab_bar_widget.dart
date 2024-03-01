import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/providers/data_provider.dart';
import 'package:v2es/util/common_util.dart';

class MyTabBar extends ConsumerWidget {
  const MyTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(tabIndexProvider);

    return SizedBox(
      height: 35,
      child: Stack(
        children: [
          SizedBox(
            width: CommonUtil.getScreenWidth(context) - 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: AppConfig.tabList.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                  width: 60,
                  child: Consumer(
                    builder: (context, ref, _) {
                      return TextButton(
                        onPressed: () {
                          if (current != index) {
                            ref.watch(tabIndexProvider.notifier).state = index;
                          }
                        },
                        style: ButtonStyle(
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(1.0))),
                        child: Text(
                          AppConfig.tabList[index].name,
                          style: index != current
                              ? const TextStyle(
                                  fontSize: 14, color: Colors.blueGrey)
                              : const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
