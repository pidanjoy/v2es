import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:provider/provider.dart';
import 'package:v2es/config/app_config.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/providers/data_provider.dart';
import 'package:v2es/util/common_util.dart';
import 'package:v2es/widget/an_rotation_widget.dart';
import 'package:v2es/widget/image_load_widget.dart';
import 'package:v2es/widget/my_app_bar_widget.dart';
import 'package:v2es/widget/topic_loading_widget.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({super.key});

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: MyAppBar(
          size: CommonUtil.getScreenHeight(context) * 0.06,
          title: Container(
            alignment: Alignment.centerLeft,
            child: const Text(
              "位面列表",
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
        body: Consumer(builder: (context, ref, _) {
          final planList = ref.watch(planListProvider);
          return planList.when(
            loading: () => const TopicLoadingWidget(),
            error: (error, stack) => const Text("Error: xxx"),
            data: (list) {
              Widget headerLeft(Plan e) => Row(
                    children: [
                      ImageLoader(
                        imageUrl: e.icon,
                        circular: 20.0,
                      ),
                      SizedBox(
                        width: CommonUtil.getScreenWidth(context) * 0.02,
                      ),
                      Text(
                        e.name,
                        style: TextStyle(
                          color: CommonUtil.hexToColor(e.color),
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        width: CommonUtil.getScreenWidth(context) * 0.02,
                      ),
                      Text(
                        e.subName,
                        style: TextStyle(
                          color: CommonUtil.hexToColor(e.color),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  );
              Widget headerRight(Plan e) => Text(
                    e.qty.toString(),
                    style: TextStyle(
                      color: CommonUtil.hexToColor(e.color),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                  );
              Widget header(Plan e) => GestureDetector(
                    onTap: () {
                      setState(() {
                        for (var i in list) {
                          if (i.name != e.name) {
                            i.isExpand = false;
                          }
                        }
                        e.isExpand = !e.isExpand;
                      });
                    },
                    child: Container(
                      color: CommonUtil.hexToColor(e.backgroundColor),
                      width: CommonUtil.getScreenWidth(context),
                      height: CommonUtil.getScreenHeight(context) * 0.08,
                      padding: EdgeInsets.all(
                        CommonUtil.getScreenWidth(context) * 0.02,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          headerLeft(e),
                          headerRight(e),
                        ],
                      ),
                    ),
                  );
              Widget nodes(Plan e) => Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: e.nodes
                        .map(
                          (n) => Text(n.title),
                        )
                        .toList(),
                  );
              return ListView(
                  children: list
                      .map((e) => Column(
                            children: e.isExpand
                                ? [header(e), nodes(e)]
                                : [header(e)],
                          ))
                      .toList());
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(
            Icons.upload,
            color: Colors.amber,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
