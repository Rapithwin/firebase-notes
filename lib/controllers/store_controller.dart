import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth;

  late Rx<NotesModel?> note;
  final Rx<bool> isLoading = false.obs;

  StoreController({required this.auth});

  Future<(bool, String)> createNote(NotesModel note) async {
    if (auth.currentUser == null) {
      return (false, "No user is currently logged in.");
    }
    isLoading.value = true;

    try {
      await db
          .collection("user")
          .doc(auth.currentUser?.uid)
          .collection("notes")
          .withConverter(
            fromFirestore: NotesModel.fromFirestore,
            toFirestore: (NotesModel note, options) => note.toFirestore(),
          )
          .add(note);

      return (true, "Note created successfully.");
    } on FirebaseException catch (e) {
      log("Firebase error", error: e);
      return (false, e.message ?? "Unknown databse error");
    } catch (e) {
      log("Error creating note", error: e);
      return (false, "An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
