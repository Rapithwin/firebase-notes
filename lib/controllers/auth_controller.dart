import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/constants/exceptions.dart';
import 'package:firebase_notes/pages/home_page.dart';
import 'package:firebase_notes/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth auth;
  final googleSignIn = GoogleSignIn.instance;
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
      log(e.message!);
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
      log(e.toString());
      return (false, e);
    } catch (e) {
      log(e.toString());
      return (false, FirebaseAuthException(code: "unknown"));
    }
  }

  void signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<(bool, dynamic)> signInWithGoogle() async {
    try {
      googleSignIn.initialize(
        serverClientId:
            "36747631786-hhl87t6cqmf5l5e3qp3e1jsb7vg47lrj.apps.googleusercontent.com",
      );
      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      return (true, userCredential);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return (false, e.message);
    } on GoogleSignInException catch (e) {
      log(e.toString());
      return (false, e.code.toMessage());
    } catch (e) {
      return (false, e);
    }
  }
}
