import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockNavigator extends Mock {
  void call(Widget page);
}

void main() {
  group("firebase auth controller", () {
    final auth = MockFirebaseAuth();
    final navigator = MockNavigator();
    final controller = AuthController(auth: auth, navigate: navigator.call);
    final email = "user@example.com";
    final password = "12345678A@M@a!";

    test("Register method calls createUserWithEmailAndPassword", () async {
      when(
        () => auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).thenAnswer(
        (_) async => MockUserCredential(),
      );

      try {
        await controller.register(email, password);
      } catch (_) {}
      verify(
        () => auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        ),
      ).called(1);
    });
  });
}
