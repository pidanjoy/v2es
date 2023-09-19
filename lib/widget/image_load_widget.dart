import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:v2es/util/http_util.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final double? circular;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final bool? enableEnlarge;

  final GestureTapCallback? onTap;

  const ImageLoader({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.enableEnlarge,
    this.circular,
    this.padding,
    this.margin,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget w1 = Container(
      width: width ?? 32.0,
      height: height ?? 32.0,
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      color: const Color.fromRGBO(0, 0, 0, 0.05),
      child: FutureBuilder(
        future: HttpUtil.loadImage(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else {
            return null != enableEnlarge && enableEnlarge!
                ? GestureDetector(
                    child: Image.memory(snapshot.data),
                    onTap: () => {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return ImageEnlarge(
                              image: Image.memory(snapshot.data),
                            );
                          },
                        ),
                      ),
                    },
                  )
                : Image.memory(snapshot.data);
          }
        },
      ),
    );
    Widget w2;
    if (null != circular) {
      w2 = ClipRRect(
        borderRadius: BorderRadius.circular(circular!),
        child: w1,
      );
    } else {
      w2 = w1;
    }
    Widget w3;
    if (null != onTap) {
      w3 = GestureDetector(
        onTap: onTap,
        child: w2,
      );
    } else {
      w3 = w2;
    }
    return w3;
  }
}

class ImageEnlarge extends StatelessWidget {
  const ImageEnlarge({super.key, required this.image});

  final Image image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: PhotoView(
            imageProvider: image.image,
          ),
          onTap: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
