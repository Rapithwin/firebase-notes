import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required ThemeController themeController,
    required this.title,
    this.actions,
  }) : _themeController = themeController;

  final ThemeController _themeController;
  final Widget title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 30,
      title: title,
      toolbarHeight: 45,
      actionsPadding: EdgeInsets.only(right: 30),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56);
}
