import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2es/model/node_model.dart';
import 'package:v2es/util/common_util.dart';
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
        body: FutureBuilder(
          future: context.watch<Future<List<Plan>>>(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const TopicLoadingWidget();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              for (var item in snapshot.data!) {
                debugPrint(item.name);
                debugPrint(item.subName);
                debugPrint(item.icon);
                debugPrint("${item.qty}");
                debugPrint(item.color);
              }
              return ListView(
                children: snapshot.data!.map((e) => Container(
                  color: CommonUtil.hexToColor(e.color),
                  width: CommonUtil.getScreenWidth(context),
                  child: Text(e.name),
                )).toList(),
              );
            }
          },
        ),
      ),
    );
  }
}
