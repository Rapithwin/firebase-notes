import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/app.dart';
import 'package:firebase_notes/constants/auth_constants.dart';
import 'package:firebase_notes/controllers/style_controller.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  Get.put(
    AuthController(
      auth: auth,
      navigate: (widget) => Get.offAll(() => widget),
    ),
  );
  Get.put(ThemeController());
  Get.lazyPut(() => StoreController(auth: auth), fenix: true);
  Get.put(StyleController());

  if (kDebugMode) {
    log("Using firebase emulator", level: 0);
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      log(e.toString());
    }
  }
  runApp(const MainApp());
}
