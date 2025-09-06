import 'package:get/get.dart';

class ItemSelectionController extends GetxController {
  Rxn<int>? selectedIndex = Rxn<int>();
  RxBool isSelectedAll = false.obs;
  RxBool isSelected = false.obs;

  void toggleIndex(int index) {
    selectedIndex?.value = index;
    isSelected.value = true;
  }

  void toggleSelectedAll() {
    isSelectedAll.value = !isSelectedAll.value;
  }
}
