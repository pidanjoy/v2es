import 'package:flutter/material.dart';

class NotebookPage extends StatefulWidget {
  const NotebookPage({super.key});

  @override
  State<NotebookPage> createState() => _NotebookPageState();
}

class _NotebookPageState extends State<NotebookPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("新建条目"),
                ),
                ElevatedButton(
                  onPressed: () => {},
                  child: Text("新建文件夹"),
                ),
              ],
            ),
            Expanded(
              child: ListView(
                children: [
                  Row(
                    children: [Icon(Icons.ac_unit), Text("文件夹1")],
                  ),
                  Row(
                    children: [Icon(Icons.ac_unit), Text("文件夹2")],
                  ),
                  Row(
                    children: [Icon(Icons.ac_unit), Text("文件夹3")],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
