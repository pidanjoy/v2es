import 'package:flutter/material.dart';
import 'package:v2es/util/http_util.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;

  const ImageLoader(
      {super.key, required this.imageUrl, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: height ?? 50,
      child: Container(
        height: 32,
        width: 32,
        color: Colors.grey,
        child: FutureBuilder(
          future: HttpUtil.loadImage(imageUrl),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else {
              return Image.memory(snapshot.data);
            }
          },
        ),
      ),
    );
  }
}
