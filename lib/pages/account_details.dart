import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/pages/change_password.dart';
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
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 5.0,
              ),
              title: Text(
                "Email",
                style: theme.textTheme.headlineSmall,
              ),
              subtitle: Text(authController.firebaseUser.value!.email!),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 5.0,
              ),
              onTap: () {
                Get.to(
                  () => ChangePassword(),
                  transition: Transition.rightToLeft,
                );
              },

              enabled: authController.isPasswordProvider,
              title: Text(
                "Change Password",
                style: theme.textTheme.headlineSmall,
              ),
              subtitle: authController.isPasswordProvider
                  ? null
                  : Text("Not available for Google Sign-in"),
              trailing: Icon(Icons.password_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
