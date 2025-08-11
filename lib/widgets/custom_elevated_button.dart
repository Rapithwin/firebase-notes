import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.theme,
    required this.title,
    this.onPressed,
  });

  final ThemeData theme;
  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.tertiary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),

      child: Text(
        title,
        style: TextStyle(
          fontFamily: "Allerta",
          color: theme.colorScheme.onPrimary,
          fontSize: 20,
        ),
      ),
    );
  }
}
