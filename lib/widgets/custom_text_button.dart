import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.theme,
    required this.title,
  });

  final ThemeData theme;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
        foregroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),

          side: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 2,
          ),
        ),
      ),

      child: Text(
        "Continue with Google",
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontFamily: "Allerta",
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
