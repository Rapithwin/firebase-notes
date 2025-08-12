import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/pages/login_page.dart';
import 'package:firebase_notes/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();

    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: themeController.themeMode.value,
        home: LoginPage(),
      ),
    );
  }
}
