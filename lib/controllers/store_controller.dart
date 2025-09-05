import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:get/get.dart';

class StoreController extends GetxController {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth auth;

  final RxList<NotesModel> notes = <NotesModel>[].obs;
  final Rx<bool> isLoading = false.obs;

  StoreController({required this.auth});

  @override
  void onInit() {
    super.onInit();
    notes.bindStream(readNotes());
  }

  Future<(bool, String)> createNote(NotesModel note) async {
    if (auth.currentUser == null) {
      return (false, "No user is currently logged in.");
    }
    isLoading.value = true;

    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.email)
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

  Stream<List<NotesModel>> readNotes() {
    if (auth.currentUser == null) {
      return Stream.value([]);
    }

    return db
        .collection("users")
        .doc(auth.currentUser!.email)
        .collection("notes")
        .withConverter(
          fromFirestore: NotesModel.fromFirestore,
          toFirestore: (note, options) => note.toFirestore(),
        )
        .snapshots()
        .map(
          (querySnapshot) {
            // Map the stream of snapshots to a list of NotesModel
            return querySnapshot.docs
                .map((docSnapshot) => docSnapshot.data())
                .toList();
          },
        );
  }

  Future<(bool, String)> updateNote(NotesModel note) async {
    if (auth.currentUser == null) {
      return (false, "No user is currently logged in.");
    }
    isLoading.value = true;

    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.email)
          .collection("notes")
          .doc(note.id)
          .update(note.toFirestore());
      return (true, "Note updated successfully.");
    } on FirebaseException catch (e) {
      log("Firebase error", error: e);
      return (false, e.message ?? "Unknown databse error");
    } catch (e) {
      log("Error updating note", error: e);
      return (false, "An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }

  Future<(bool, String)> deleteNote(String noteId) async {
    if (auth.currentUser == null) {
      return (false, "No user is currently logged in.");
    }
    isLoading.value = true;

    try {
      await db
          .collection("users")
          .doc(auth.currentUser!.email)
          .collection("notes")
          .doc(noteId)
          .delete();
      return (true, "Note deleted successfully");
    } on FirebaseException catch (e) {
      log("Firebase error", error: e);
      return (false, e.message ?? "Unknown databse error");
    } catch (e) {
      log("Error deleting note", error: e);
      return (false, "An unexpected error occurred");
    } finally {
      isLoading.value = false;
    }
  }
}
