import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/pages/change_password.dart';
import 'package:firebase_notes/pages/settings_page.dart';
import 'package:firebase_notes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: CustomAppBar(
        titleSpacing: 0,
        title: Text("ACCOUNT DETAILS"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26.0),
              child: SizedBox(
                height: 65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    Text(
                      "Email",
                      style: theme.textTheme.headlineSmall,
                    ),
                    Text(authController.firebaseUser.value!.email!),
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(
                  () => ChangePassword(),
                  transition: Transition.rightToLeft,
                );
              },
              child: SettingsOption(
                theme: theme,
                title: "Change password",
                icon: Icon(Icons.password_outlined),
                enabled: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
