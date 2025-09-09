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

extension LayoutToString on Layout {
  String get layoutToString {
    switch (this) {
      case Layout.grid:
        return "Grid view";
      case Layout.list:
        return "List view";
    }
  }
}

extension StringToStyle on String {
  FontSize get stringToFontSize {
    switch (this) {
      case "Small":
        return FontSize.small;
      case "Medium":
        return FontSize.medium;
      case "Large":
        return FontSize.large;
      case "Huge":
        return FontSize.huge;
      default:
        throw Exception("Unsupported string");
    }
  }

  Layout get stringToLayout {
    if (this == "Grid view") {
      return Layout.grid;
    } else if (this == "List view") {
      return Layout.list;
    } else {
      throw Exception("Unsupported string");
    }
  }
}
