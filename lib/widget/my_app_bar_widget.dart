import 'package:flutter/material.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar(
      {super.key,
      required this.size,
      this.actions,
      this.leading,
      this.title,
      this.backIcon});

  final double size;

  final IconData? backIcon;
  final Widget? leading;
  final Widget? title;
  final List<Widget>? actions;

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(size);
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromRGBO(35, 29, 40, 1.0),
      automaticallyImplyLeading: false,
      leading: widget.leading ??
          IconButton(
            icon: Icon(
              widget.backIcon ?? Icons.arrow_back_ios_new_rounded,
              size: 18,
            ),
            color: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
      title: widget.title ??
          const Text(
              'V2EX',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
      actions: widget.actions ?? [],
    );
  }
}
