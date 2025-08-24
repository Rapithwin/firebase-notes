import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditPage extends StatelessWidget {
  const AddEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: CustomAppBar(
        themeController: themeController,
        title: Text(""),
        titleSpacing: 0,
        actions: [
          Icon(Icons.check),
        ],
      ),
    );
  }
}
