import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/pages/home_page.dart';
import 'package:firebase_notes/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth;
  final void Function(Widget) navigate;

  AuthController({required this.auth, required this.navigate});

  late Rx<User?> firebaseUser;

  @override
  void onReady() {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      navigate(const HomePage());
    } else {
      navigate(LoginPage());
    }
  }

  Future<(bool, FirebaseAuthException?)> register(
    String email,
    String password,
  ) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (true, null);
    } on FirebaseAuthException catch (e) {
      return (false, e);
    } catch (e) {
      log(e.toString());
      return (false, FirebaseAuthException(code: "unknown"));
    }
  }

  Future<(bool, FirebaseAuthException?)> login(
    String email,
    String password,
  ) async {
    try {
      await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return (true, null);
    } on FirebaseAuthException catch (e) {
      return (false, e);
    } catch (e) {
      log(e.toString());
      return (false, FirebaseAuthException(code: "unknown"));
    }
  }

  void signOut() {
    try {
      auth.signOut();
    } catch (e) {
      log(e.toString());
    }
  }
}
