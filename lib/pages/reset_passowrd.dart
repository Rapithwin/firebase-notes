import 'package:firebase_notes/controllers/auth_controller.dart';
import 'package:firebase_notes/widgets/custom_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPassowrdPage extends StatefulWidget {
  const ResetPassowrdPage({super.key});

  @override
  State<ResetPassowrdPage> createState() => _ResetPassowrdPageState();
}

class _ResetPassowrdPageState extends State<ResetPassowrdPage> {
  final _emailController = TextEditingController();
  final _authController = Get.find<AuthController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text("RESET PASSWORD"),
        titleSpacing: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 65.0,
              ),
              CustomFormField(
                labelName: "Email address",
                textDirection: TextDirection.ltr,
                inputAction: TextInputAction.done,
                controller: _emailController,
                theme: theme,
                validator: emptyValidator,
              ),
              SizedBox(
                width: double.infinity,
                height: 35,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: CustomElevatedButton(
                    theme: theme,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      final result = await _authController.resetPassword(
                        _emailController.text,
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
                    title: Obx(
                      () => _authController.isLoading.value
                          ? const CircularProgressIndicator()
                          : Text(
                              "Send reset password email",
                              style: TextStyle(
                                fontFamily: "Allerta",
                                color: theme.colorScheme.onPrimary,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ],
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
