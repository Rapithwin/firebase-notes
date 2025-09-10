import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    required this.titleSpacing,
  });

  final Widget title;
  final List<Widget>? actions;
  final double titleSpacing;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: titleSpacing,
      title: title,
      toolbarHeight: 45,
      actionsPadding: EdgeInsets.only(right: 30),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
