import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            authController.signOut();
          },
          child: Text("Sing out"),
        ),
      ),
    );
  }
}
