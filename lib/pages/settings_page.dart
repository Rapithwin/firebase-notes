import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: CustomAppBar(
        themeController: themeController,
        title: Text("SETTINGS"),
      ),
    );
  }
}
