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
    return Container(
      width: width ?? 32.0,
      // height: height ?? Size.zero.height,
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
    );
  }
}
