import 'package:firebase_notes/pages/signup_page.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 30,
        title: Text("LOG IN"),
        toolbarHeight: 45,
        actionsPadding: EdgeInsets.only(right: 30),
        actions: [
          Image.asset(
            "assets/images/solar_sun-bold.png",
            width: 35,
            height: 35,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              children: <Widget>[
                CustomFormField(
                  labelName: "Email",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: TextEditingController(),
                  theme: theme,
                ),
                CustomFormField(
                  labelName: "Password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: TextEditingController(),
                  theme: theme,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: CustomElevatedButton(
                      theme: theme,
                      title: "LOG IN",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 7,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: CustomTextButton(
                      theme: theme,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 7,
                        children: [
                          Image.asset(
                            "assets/images/devicon_google.png",
                            width: 20,
                            height: 20,
                          ),
                          Text(
                            "Continue with Google",
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontFamily: "Allerta",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Get.off(SignupPage()),
                      child: Text(
                        "Sign Up.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.tertiary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Text(
                    "Reset Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: theme.colorScheme.tertiary,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.tertiary,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
