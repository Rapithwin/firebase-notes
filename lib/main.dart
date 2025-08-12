import 'package:firebase_notes/app.dart';
import 'package:firebase_notes/constants/auth_constants.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  Get.put(
    AuthController(
      auth: auth,
      navigate: (widget) => Get.offAll(() => widget),
    ),
  );
  Get.put(ThemeController());
  runApp(const MainApp());
}
