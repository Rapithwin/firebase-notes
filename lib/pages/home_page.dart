import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
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
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
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
          Icon(
            Icons.settings_outlined,
            size: 33,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Icon(Icons.edit_outlined),
      ),
      body: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            color: theme.colorScheme.surfaceContainerLow,
            child: Container(
              height: (index % 5 + 1) * 80,
              alignment: Alignment.center,
              child: Text('Note $index'),
            ),
          );
        },
      ),
    );
  }
}
