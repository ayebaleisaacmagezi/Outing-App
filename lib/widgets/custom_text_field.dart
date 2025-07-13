import 'package:flutter/material.dart';
import '../main.dart' show AppColors; // Correct import

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.electricCyan.withOpacity(0.7)),
        filled: true,
        fillColor: Theme.of(context).inputDecorationTheme.fillColor,
        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
        border: Theme.of(context).inputDecorationTheme.border,
        enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
        focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
      ),
    );
  }
}