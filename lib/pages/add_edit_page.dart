import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditPage extends StatelessWidget {
  const AddEditPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: CustomAppBar(
        themeController: themeController,
        title: Text(""),
        titleSpacing: 0,
        actions: [
          Icon(Icons.check),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 26.0, right: 26.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 13,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 30,
                  color: theme.colorScheme.onSurface,
                ),
                minLines: 1,
                maxLines: 3,
                maxLength: 200,
                decoration: InputDecoration.collapsed(
                  hintText: "Title",

                  hintStyle: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 30,
                    color: theme.colorScheme.surfaceContainerHighest,
                  ),
                ),
              ),
              Text(
                "June 21, 2023, 6:00pm",
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SingleChildScrollView(
                child: TextField(
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    color: theme.colorScheme.onSurface,
                  ),
                  minLines: 1,
                  maxLines: null,
                  decoration: InputDecoration.collapsed(
                    hintText: "Start typing...",

                    hintStyle: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 24,
                      color: theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
