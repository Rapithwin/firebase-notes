import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  late Rx<NotesModel?> note;
  final Rx<bool> isLoading = false.obs;
}
