import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/style_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/enums/enums.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/pages/add_edit_page.dart';
import 'package:firebase_notes/pages/home_page/widgets/widgets.dart';
import 'package:firebase_notes/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();
  final storeController = Get.find<StoreController>();
  final styleController = Get.find<StyleController>();

  final fakeNotes = List.filled(
    15,
    NotesModel(
      content: "Some content",
      title: "title",
      dateModified: DateTime(2020, 9, 7),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => !storeController.anyNotesSelected()
              ? AppBar(
                  titleSpacing: 25,
                  // themeController: themeController,
                  actionsPadding: EdgeInsets.only(right: 25),
                  title: Text("NOTES"),
                  actions: [
                    GestureDetector(
                      onTap: () {
                        themeController.toggleTheme();
                      },
                      child: Get.isDarkMode
                          ? Image.asset(
                              "assets/images/solar_sun-bold.png",
                              height: 30,
                              width: 30,
                            )
                          : Image.asset(
                              "assets/images/line-md_moon-filled.png",
                              height: 30,
                              width: 30,
                            ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(
                          () => SettingsPage(),
                          transition: Transition.rightToLeft,
                        );
                      },
                      child: Icon(
                        Icons.settings_outlined,
                        size: 33,
                      ),
                    ),
                  ],
                )
              : AppBar(
                  actionsPadding: EdgeInsets.only(right: 15),
                  leadingWidth: 80,
                  leading: IconButton(
                    onPressed: () {
                      Get.dialog(
                        transitionCurve: Curves.ease,
                        AlertDialog(
                          alignment: Alignment.bottomCenter,
                          backgroundColor:
                              theme.colorScheme.surfaceContainerLow,
                          title: Text(
                            "DELETE NOTES",
                            textAlign: TextAlign.center,
                          ),

                          content: Text(
                            "Delete ${storeController.selectedIds.length} item(s)?",
                            textAlign: TextAlign.center,
                          ),
                          actionsAlignment: MainAxisAlignment.center,

                          actions: [
                            TextButton(
                              onPressed: () {
                                storeController.deleteNote();
                                storeController.clearSelected();
                                Get.back();
                              },
                              style: TextButton.styleFrom(
                                overlayColor: theme.colorScheme.error,
                              ),
                              child: Text(
                                "Delete",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Get.back(),

                              child: Text(
                                "Cancel",
                                style: theme.textTheme.labelLarge?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.delete_outline_outlined,
                      size: 30,
                    ),
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        storeController.clearSelected();
                      },
                      icon: Icon(
                        Icons.close,
                        size: 30,
                      ),
                    ),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddEditPage(), transition: Transition.zoom);
        },
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.edit_outlined),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: StreamBuilder<List<NotesModel>>(
          stream: storeController.readNotes(),

          builder: (context, snapshot) {
            Get.log(snapshot.connectionState.toString());
            Get.log(snapshot.data.toString());

            if (snapshot.data != null && snapshot.data!.isEmpty) {
              return Center(
                child: Text(
                  "No notes found",
                  style: theme.textTheme.headlineMedium,
                ),
              );
            }
            final List<NotesModel> notes = snapshot.data == null
                ? fakeNotes
                : storeController.notes;

            return Skeletonizer(
              enabled: snapshot.connectionState == ConnectionState.waiting,
              effect: PulseEffect(),
              child: Obx(
                () {
                  return styleController.layout.value == Layout.grid
                      ? GridNotes(
                          controller: storeController,
                          theme: theme,
                          notes: notes,
                        )
                      : ListNotes(
                          controller: storeController,
                          theme: theme,
                          notes: notes,
                        );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
