import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/constants/exceptions.dart';
import 'package:firebase_notes/pages/home_page/home_page.dart';
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
  final Rx<bool> isLoading = false.obs;

  @override
  void onReady() async {
    super.onReady();

    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());

    ever(firebaseUser, _setInitialScreen);
    // Ensure the locally cached user still exists on the server (detect remote deletion)
    await _ensureUserValid();
  }

  _setInitialScreen(User? user) {
    if (user != null) {
      navigate(const HomePage());
    } else {
      navigate(const LoginPage());
    }
  }

  bool get isPasswordProvider {
    if (auth.currentUser == null) return false;
    return auth.currentUser!.providerData.any(
      (userInfo) => userInfo.providerId == 'password',
    );
  }

  // Reload the current user to force a server check. If the user was removed
  // remotely (for example in the emulator), reload may fail or auth.currentUser
  // can become null — in that case sign out locally and navigate to login.
  Future<void> _ensureUserValid() async {
    final user = auth.currentUser;
    if (user == null) return;

    try {
      await user.reload();
      // After reload the SDK may have cleared the user
      if (auth.currentUser == null) {
        await signOut();
        navigate(const LoginPage());
      }
    } on FirebaseAuthException catch (e) {
      log('User reload failed: ${e.code} ${e.message}');
      try {
        await signOut();
      } catch (_) {}
      navigate(const LoginPage());
    } catch (e) {
      log('Unexpected error while validating user: $e');
    }
  }

  Future<(bool, FirebaseAuthException?)> register(
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<(bool, FirebaseAuthException?)> login(
    String email,
    String password,
  ) async {
    try {
      isLoading.value = true;
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
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      await googleSignIn.signOut();
    } catch (e) {
      log(e.toString());
    }
  }

  Future<(bool, FirebaseAuthException?)> changePassword(
    String oldPassword,
    String newPassowrd,
  ) async {
    if (!isPasswordProvider || auth.currentUser == null) {
      return (
        false,
        FirebaseAuthException(
          code: 'wrong-provider',
          message: 'This function is not available for this sign-in method.',
        ),
      );
    }
    try {
      final email = firebaseUser.value?.email;

      isLoading.value = true;
      final credential = EmailAuthProvider.credential(
        email: email!,
        password: oldPassword,
      );

      await firebaseUser.value?.reauthenticateWithCredential(
        credential,
      );
      await firebaseUser.value?.updatePassword(newPassowrd);
      return (true, null);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return (false, e);
    } catch (e) {
      log(e.toString());
      return (false, FirebaseAuthException(code: "unknown"));
    } finally {
      isLoading.value = false;
    }
  }

  Future<(bool, FirebaseAuthException?)> resetPassword(String email) async {
    try {
      isLoading.value = true;

      await auth.sendPasswordResetEmail(email: email);
      return (true, null);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      return (false, e);
    } catch (e) {
      log(e.toString());
      return (false, FirebaseAuthException(code: "unknown"));
    } finally {
      isLoading.value = false;
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
