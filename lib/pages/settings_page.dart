import 'package:firebase_notes/controllers/style_controller.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/enums/enums.dart';
import 'package:firebase_notes/extensions/extensions.dart';
import 'package:firebase_notes/pages/account_details.dart';
import 'package:firebase_notes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthController authController = Get.find<AuthController>();
    final StyleController styleController = Get.find<StyleController>();
    return Scaffold(
      appBar: const CustomAppBar(
        titleSpacing: 0,
        title: Text("SETTINGS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),

            SettingsTitle(title: "Style", theme: theme),

            Obx(
              () => SettingsOption(
                menuItems: [
                  PopupMenuItem(
                    child: const Text("Huge"),
                    onTap: () {
                      styleController.changeFontSize(FontSize.huge);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Large"),
                    onTap: () {
                      styleController.changeFontSize(FontSize.large);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Medium"),
                    onTap: () {
                      styleController.changeFontSize(FontSize.medium);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Small"),
                    onTap: () {
                      styleController.changeFontSize(FontSize.small);
                    },
                  ),
                ],
                enabled: true,
                theme: theme,
                title: "Font size",
                trailing: styleController.fontSize.value.fontToString,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 25,
                ),
              ),
            ),
            Obx(
              () => SettingsOption(
                menuItems: [
                  PopupMenuItem(
                    child: const Text("List view"),
                    onTap: () {
                      styleController.changeLayout(Layout.list);
                    },
                  ),
                  PopupMenuItem(
                    child: const Text("Grid view"),
                    onTap: () {
                      styleController.changeLayout(Layout.grid);
                    },
                  ),
                ],
                enabled: true,
                theme: theme,

                title: "Layout",
                trailing: styleController.layout.value.layoutToString,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 25,
                ),
              ),
            ),
            const Divider(
              endIndent: 26,
              indent: 26,
            ),
            SettingsTitle(
              theme: theme,
              title: "Account",
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => const AccountDetails(),
                  transition: Transition.rightToLeft,
                );
              },
              child: SettingsOption(
                enabled: false,
                theme: theme,
                title: "Account details",
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
            ),

            InkWell(
              onTap: () {
                Get.dialog(
                  AlertDialog(
                    alignment: Alignment.bottomCenter,
                    backgroundColor: theme.colorScheme.surfaceContainerLow,
                    title: const Text(
                      "LOG OUT",
                      textAlign: TextAlign.center,
                    ),

                    content: const Text(
                      "Log out of your account?",
                      textAlign: TextAlign.center,
                    ),
                    actionsAlignment: MainAxisAlignment.center,

                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),

                        child: Text(
                          "Cancel",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          authController.signOut();
                        },
                        style: TextButton.styleFrom(
                          overlayColor: theme.colorScheme.error,
                        ),
                        child: Text(
                          "Log out",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: SettingsOption(
                enabled: false,
                theme: theme,
                title: "Log out",
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 18,
                ),
              ),
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
    required this.enabled,
    this.menuItems,
    this.trailing,
  });

  final ThemeData theme;
  final String title;
  final Icon icon;
  final String? trailing;
  final bool enabled;
  final List<PopupMenuItem>? menuItems;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: Padding(
        padding: const EdgeInsets.only(right: 18.0, left: 26.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.headlineSmall,
            ),

            PopupMenuButton(
              position: PopupMenuPosition.over,
              enabled: enabled,
              borderRadius: BorderRadius.circular(12),
              itemBuilder: (context) {
                return menuItems ?? [];
              },

              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
