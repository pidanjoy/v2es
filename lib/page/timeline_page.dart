import 'package:flutter/material.dart';

class TimelinePage extends StatefulWidget {
  const TimelinePage({super.key});

  @override
  State<TimelinePage> createState() => _TimelinePageState();
}

class _TimelinePageState extends State<TimelinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromRGBO(210, 210, 210, 1),
          child: Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Timeline"),
                        TextButton(
                          onPressed: () => {},
                          child: Text("发布"),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(
                        helperText: "这一刻的想法...",
                        border: InputBorder.none,
                      ),
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (null == value || value.isEmpty) {
                          return "请输入内容";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        debugPrint(value);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text("Timeline"),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            child: Text("Mentions"),
                          ),
                        ],
                      ),
                      Text("datadatadatadatadatadatadatadata"),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
