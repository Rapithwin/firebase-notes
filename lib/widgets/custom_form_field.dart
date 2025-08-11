import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  const CustomFormField({
    super.key,
    this.validator,
    required this.labelName,
    required this.textDirection,
    this.onChanged,
    required this.inputAction,
    this.initialValue,
    this.keyboardType,
    this.obscureText,
    required this.controller,
    required this.theme,
    this.maxLines,
  });

  final String? initialValue;
  final String? Function(String?)? validator;
  final String labelName;
  final TextDirection textDirection;
  final TextInputAction inputAction;
  final TextInputType? keyboardType;
  final Function(String?)? onChanged;
  final bool? obscureText;
  final TextEditingController controller;
  final ThemeData theme;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelName,
            style: TextStyle(
              fontFamily: "DidactGothic",
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          TextFormField(
            maxLines: maxLines ?? 4,
            minLines: 1,
            maxLength: null,
            controller: controller,
            textDirection: textDirection,
            initialValue: initialValue,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            onChanged: onChanged,
            textInputAction: inputAction,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurface,
            ),
            validator: validator,
            decoration: InputDecoration(
              errorMaxLines: 2,
              errorStyle: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.error,

                fontSize: 12,
              ),

              contentPadding: const EdgeInsets.all(13.0),
              hintStyle: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: theme.colorScheme.outline,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(
                  color: theme.colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
