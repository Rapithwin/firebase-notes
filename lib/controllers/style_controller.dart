import 'package:firebase_notes/enums/enums.dart';
import 'package:get/get.dart';

class StyleController extends GetxController {
  Rx<FontSize> fontSize = FontSize.medium.obs;
  Rx<Layout> layout = Layout.list.obs;

  double get scaleFactor {
    switch (fontSize.value) {
      case FontSize.small:
        return 0.9;
      case FontSize.medium:
        return 1.0;
      case FontSize.large:
        return 1.2;
      case FontSize.huge:
        return 1.5;
    }
  }

  void changeFontSize(FontSize inputFontSize) {
    fontSize.value = inputFontSize;
  }

  void changeLayout(Layout inputLayout) {
    layout.value = inputLayout;
  }
}
