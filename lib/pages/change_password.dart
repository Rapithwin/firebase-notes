import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late TextEditingController _oldPasswordController,
      _newPasswordController,
      _confirmPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _authController = Get.find<AuthController>();

  @override
  void initState() {
    _newPasswordController = TextEditingController();
    _oldPasswordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _confirmPasswordController.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("CHANGE PASSWORD"),
        titleSpacing: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 36.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                CustomFormField(
                  labelName: "Old password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _oldPasswordController,
                  theme: theme,
                  validator: emptyValidator,
                ),
                CustomFormField(
                  labelName: "New password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _newPasswordController,
                  theme: theme,
                  validator: emptyValidator,
                ),
                CustomFormField(
                  labelName: "Confirm new password",
                  textDirection: TextDirection.ltr,
                  inputAction: TextInputAction.next,
                  controller: _confirmPasswordController,
                  theme: theme,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return emptyValidator(value);
                    } else if (value != _newPasswordController.text) {
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
                            "CHANGE PASSWORD",
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
                            await _authController.changePassword(
                              _oldPasswordController.text,
                              _newPasswordController.text,
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
