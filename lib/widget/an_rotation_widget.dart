import 'package:flutter/material.dart';

class AnRotation extends StatefulWidget {
  const AnRotation({super.key, required this.child, this.duration});

  final Widget child;
  final int? duration;

  @override
  State<AnRotation> createState() => _AnRotationState();
}

class _AnRotationState extends State<AnRotation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _anController = AnimationController(
      duration: Duration(seconds: widget.duration ?? 720), vsync: this)
    ..repeat();

  @override
  void dispose() {
    super.dispose();
    _anController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      alignment: Alignment.center,
      turns: Tween(begin: 0.0, end: 360.0).animate(_anController),
      child: widget.child,
    );
  }
}
