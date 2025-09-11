import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/controllers/theme_controller.dart';
import 'package:firebase_notes/pages/login_page.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final ThemeController _themeController = Get.find<ThemeController>();
  final AuthController _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController,
      _passwordController,
      _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: CustomAppBar(
        titleSpacing: 30,
        title: const Text("SIGN UP"),
        actions: [
          GestureDetector(
            onTap: () {
              _themeController.toggleTheme();
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
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomFormField(
                  labelName: "Email",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _emailController,
                  theme: theme,
                  validator: emptyValidator,
                ),
                CustomFormField(
                  labelName: "Password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _passwordController,
                  theme: theme,
                  maxLines: 1,
                  validator: emptyValidator,
                  obscureText: true,
                ),
                CustomFormField(
                  labelName: "Confirm Password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _confirmPasswordController,
                  theme: theme,
                  maxLines: 1,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return emptyValidator(value);
                    } else if (value != _passwordController.text) {
                      return "Passwords do not match.";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    height: 35,
                    child: CustomElevatedButton(
                      theme: theme,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 6,
                        children: [
                          Text(
                            "SIGN UP",
                            style: TextStyle(
                              fontFamily: "Allerta",
                              color: theme.colorScheme.onPrimary,
                              fontSize: 20,
                            ),
                          ),
                          Obx(() {
                            return Visibility(
                              visible: _authController.isLoading.value,
                              child: SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  color: theme.colorScheme.onPrimary,
                                  strokeWidth: 2.6,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                      onPressed: () async {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }

                        (bool, FirebaseAuthException?) result =
                            await _authController.register(
                              _emailController.text.trim(),
                              _passwordController.text,
                            );
                        if (!result.$1) {
                          Get.snackbar(
                            "Error",
                            result.$2!.message!,
                            backgroundColor: theme.colorScheme.error.withAlpha(
                              220,
                            ),

                            colorText: theme.colorScheme.onError,
                          );
                        }
                      },
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
                      onPressed: () async {
                        final result = await _authController.signInWithGoogle();
                        if (result.$1 == false && result.$2 != null) {
                          Get.snackbar(
                            "Error",
                            result.$2!.message!,
                            backgroundColor: theme.colorScheme.error.withAlpha(
                              220,
                            ),
                            colorText: theme.colorScheme.onError,
                          );
                        }
                      },
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
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: () => Get.off(() => const LoginPage()),
                      child: Text(
                        "Log In.",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.tertiary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? emptyValidator(String? value) {
    if (value!.isEmpty) {
      return "This field cannot be empty.";
    }
    return null;
  }
}
