import 'package:flutter/material.dart';

class TextTag extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;

  const TextTag({super.key, required this.text, this.margin, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1),
      margin: margin ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(30, 30, 30, 0.45),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        " • $text ",
        style: TextStyle(
            fontSize: fontSize ?? 10.0,
            fontWeight: FontWeight.bold,
            color: Colors.white),
      ),
    );
  }
}
