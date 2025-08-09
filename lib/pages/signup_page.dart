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
    );
  }
}
