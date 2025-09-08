import 'package:firebase_notes/enums/enums.dart';
import 'package:firebase_notes/extensions/extensions.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StyleController extends GetxController {
  Rx<FontSize> fontSize = FontSize.medium.obs;
  Rx<Layout> layout = Layout.list.obs;

  @override
  void onInit() {
    loadFontSize();
    super.onInit();
  }

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

  void loadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    final prefsFontSize = prefs.getString("fontSize")!.stringToFontSize;
    fontSize.value = prefsFontSize;
  }

  void changeFontSize(FontSize inputFontSize) async {
    fontSize.value = inputFontSize;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("fontSize", inputFontSize.fontToString);
  }

  void changeLayout(Layout inputLayout) {
    layout.value = inputLayout;
  }
}
