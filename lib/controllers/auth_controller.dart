import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/constants/auth_constants.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
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
      Get.offAll(() => const HomePage());
    } else {
      Get.offAll(() => const LoginPage());
    }
  }
}
