import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/pages/add_edit_page.dart';
import 'package:firebase_notes/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();
  final storeController = Get.find<StoreController>();

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
                  titleSpacing: 30,
                  // themeController: themeController,
                  actionsPadding: EdgeInsets.only(right: 30),
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
                  actionsPadding: EdgeInsets.only(right: 23),
                  leadingWidth: 90,
                  leading: IconButton(
                    onPressed: () {},
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
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: GetX<StoreController>(
          init: StoreController(auth: FirebaseAuth.instance),
          initState: (_) {},
          builder: (controller) {
            if (controller.notes.isEmpty) {
              return Center(
                child: Text(
                  "No notes found",
                  style: theme.textTheme.headlineSmall,
                ),
              );
            }
            return ListNotes(controller: controller, theme: theme);
          },
        ),
      ),
    );
  }
}

class ListNotes extends StatefulWidget {
  const ListNotes({
    super.key,
    required this.controller,
    required this.theme,
  });

  final StoreController controller;
  final ThemeData theme;

  @override
  State<ListNotes> createState() => _ListNotesState();
}

class _ListNotesState extends State<ListNotes> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = widget.theme.colorScheme;
    final notes = widget.controller.notes;

    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Obx(
          () => Card(
            color: widget.controller.isSelectedById(notes[index].id)
                ? colorScheme.secondaryContainer
                : colorScheme.surfaceContainerHighest,
            child: InkWell(
              splashFactory: InkSparkle.splashFactory,
              onTap: () {
                widget.controller.anyNotesSelected()
                    ? widget.controller.toggleSelected(index)
                    : Get.to(
                        () => AddEditPage(
                          note: notes[index],
                        ),
                        transition: Transition.zoom,
                      );
              },

              onLongPress: () {
                widget.controller.toggleSelected(index);
              },

              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  top: 10,
                  right: 15,
                ),
                width: Get.size.width,
                height: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      notes[index].title ?? "",
                      style: widget.theme.textTheme.titleLarge,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      notes[index].content ?? "",
                      maxLines: 1,
                      style: widget.theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat(
                              'MMMM d, yyyy',
                            ).format(notes[index].dateModified!),
                            maxLines: 1,
                            style: widget.theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),

                          Visibility(
                            visible: widget.controller.anyNotesSelected(),
                            child: Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                shape: CircleBorder(),

                                value: widget.controller.isSelectedById(
                                  notes[index].id,
                                ),
                                onChanged: (_) {
                                  widget.controller.toggleSelected(index);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class GridNotes extends StatelessWidget {
  const GridNotes({
    super.key,
    required this.mockNote,
    required this.theme,
  });

  final Map<String, String> mockNote;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      crossAxisCount: 2,

      itemCount: mockNote.length,
      itemBuilder: (context, index) {
        return Card(
          color: theme.colorScheme.surfaceContainerHigh,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(16),
          ),
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(16),

            child: Container(
              height: mockNote.values.toList()[index].length.toDouble() + 65,
              constraints: BoxConstraints(
                minHeight: Get.size.height / 14,
                maxHeight: Get.size.height / 6.5,
              ),

              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  top: 12.0,
                  right: 8.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12,
                  children: [
                    Text(
                      mockNote.keys.toList()[index],
                      style: theme.textTheme.titleLarge,
                    ),

                    Text(
                      mockNote.values.toList()[index],
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
