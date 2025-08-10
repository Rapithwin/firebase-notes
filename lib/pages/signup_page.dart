import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        titleSpacing: 30,
        title: Text("SIGN UP"),
        toolbarHeight: 45,
        actionsPadding: EdgeInsets.only(right: 30),
        actions: [
          Icon(
            Icons.sunny,
            size: 30,
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
                CustomFormField(
                  labelName: "Confirm Password",
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
                      title: "SIGN UP",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: CustomTextButton(
                      theme: theme,
                      title: "Continue with Google",
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
