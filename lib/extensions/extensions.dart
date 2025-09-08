import 'package:firebase_notes/enums/enums.dart';

extension FontSizeToString on FontSize {
  String get fontToString {
    switch (this) {
      case FontSize.small:
        return "Small";
      case FontSize.medium:
        return "Medium";
      case FontSize.large:
        return "Large";
      case FontSize.huge:
        return "Huge";
    }
  }
}
