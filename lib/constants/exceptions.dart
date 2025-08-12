import 'package:google_sign_in/google_sign_in.dart';

extension GoogleExceptionCodeToMessage on GoogleSignInExceptionCode {
  String? toMessage() {
    switch (this) {
      case GoogleSignInExceptionCode.canceled:
        return null;
      case GoogleSignInExceptionCode.interrupted:
        return "Operation intereupted";
      default:
        return "Unknown Error";
    }
  }
}
