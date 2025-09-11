import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.theme,
    required this.title,
    required this.onPressed,
  });

  final ThemeData theme;
  final Widget title;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.all(0),
        foregroundColor: theme.colorScheme.secondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),

          side: BorderSide(
            color: theme.colorScheme.outlineVariant,
            width: 2,
          ),
        ),
      ),

      child: title,
    );
  }
}
