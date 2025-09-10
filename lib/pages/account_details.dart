import 'package:firebase_notes/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class AccountDetails extends StatelessWidget {
  const AccountDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        titleSpacing: 0,
        title: Text("ACCOUNT DETAILS"),
      ),
    );
  }
}
