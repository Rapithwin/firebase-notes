import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeController themeController = Get.find<ThemeController>();
    final AuthController authController = Get.find<AuthController>();
    return Scaffold(
      appBar: CustomAppBar(
        titleSpacing: 0,
        themeController: themeController,
        title: Text("SETTINGS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),

            SettingsTitle(title: "Style", theme: theme),
            SettingsOption(
              theme: theme,
              title: "Font size",
              trailing: "Medium",
              icon: Icon(
                Icons.arrow_drop_down,
                size: 25,
              ),
              onTap: () {},
            ),
            SettingsOption(
              theme: theme,
              title: "Layout",
              trailing: "List view",
              icon: Icon(
                Icons.arrow_drop_down,
                size: 25,
              ),
              onTap: () {},
            ),
            Divider(
              endIndent: 26,
              indent: 26,
            ),
            SettingsTitle(
              theme: theme,
              title: "Account",
            ),
            SettingsOption(
              theme: theme,
              title: "Account details",
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () {},
            ),

            SettingsOption(
              theme: theme,
              title: "Sign out",
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 18,
              ),
              onTap: () async {
                await authController.signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsTitle extends StatelessWidget {
  const SettingsTitle({
    super.key,
    required this.title,
    required this.theme,
  });

  final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Text(
        title,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

class SettingsOption extends StatelessWidget {
  const SettingsOption({
    super.key,
    required this.theme,
    required this.title,
    required this.icon,
    required this.onTap,
    this.trailing,
  });

  final ThemeData theme;
  final String title;
  final Icon icon;
  final GestureTapCallback onTap;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 65,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: theme.textTheme.headlineSmall,
              ),
              Row(
                spacing: 16,
                children: [
                  Text(
                    trailing ?? "",
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  icon,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
