import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/store_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/models/notes_model.dart';
import 'package:firebase_notes/pages/add_edit_page.dart';
import 'package:firebase_notes/pages/settings_page.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authController = Get.find<AuthController>();
  final themeController = Get.find<ThemeController>();

  Map<String, String> mockNote = {
    "title 1": "Hello this is title 1 ",
    "title 2": "Hello this is title 2 and it's supposed to be 2 ",
    "title 3":
        "Hello this is title 3 and I'm writing it a little bit longer than the other one.",
    "title 4":
        "Hello there and welcome to title 4. I am deliberately writing this longer than usual to see how many lines it will be.",
  };

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        titleSpacing: 30,
        themeController: themeController,
        title: Text("NOTES"),
        actions: [
          GestureDetector(
            onTap: () {
              themeController.toggleTheme();
            },
            child: Get.isDarkMode
                ? Image.asset(
                    "assets/images/solar_sun-bold.png",
                    height: 35,
                    width: 35,
                  )
                : Image.asset(
                    "assets/images/line-md_moon-filled.png",
                    height: 35,
                    width: 35,
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
            return ListNotes(notes: controller.notes, theme: theme);
          },
        ),
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  const ListNotes({
    super.key,
    required this.notes,
    required this.theme,
  });

  final List<NotesModel> notes;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        return Card(
          color: theme.colorScheme.surfaceContainerHigh,
          child: InkWell(
            onTap: () {
              Get.to(
                () => AddEditPage(
                  note: notes[index],
                ),
                transition: Transition.zoom,
              );
            },
            borderRadius: BorderRadius.circular(16),
            child: Container(
              // margin: EdgeInsets.only(bottom: 8),s
              padding: EdgeInsets.only(
                left: 15,
                top: 10,
                right: 15,
              ),
              width: Get.size.width,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes[index].title ?? "",
                    style: theme.textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    notes[index].content ?? "",
                    maxLines: 1,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
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
