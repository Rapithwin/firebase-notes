import 'package:firebase_notes/app.dart';
import 'package:firebase_notes/constants/auth_constants.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  firebaseInitialization.then((val) {
    Get.put(
      AuthController(
        auth: auth,
        navigate: (widget) => Get.offAll(() => widget),
      ),
    );
  });
  runApp(const MainApp());
}
