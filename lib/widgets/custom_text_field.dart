import 'package:flutter/material.dart';
import '../main.dart' show AppColors; // Correct import

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    this.isPassword = false,
    this.controller,
  });

    @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // 1. State variable to track password visibility
  bool _isObscured = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: widget.hintText,
        prefixIcon: Icon(widget.icon, color: AppColors.electricCyan.withOpacity(0.7)),
         // 3. Add the visibility toggle icon as a suffix
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  // Choose the icon based on the visibility state
                  _isObscured ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey[500],
                ),
                onPressed: () {
                  // 4. When pressed, update the state to toggle visibility
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              )
            : null, // If it's not a password field, don't show any suffix icon
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