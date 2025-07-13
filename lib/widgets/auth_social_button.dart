// lib/widgets/auth_social_button.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthSocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String iconPath;
  final String label;
  final bool isSvgDark;

  const AuthSocialButton({
    super.key,
    required this.onPressed,
    required this.iconPath,
    required this.label,
    this.isSvgDark = false,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(color: Colors.grey[800]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 20,
            width: 20,
            colorFilter: isSvgDark ? const ColorFilter.mode(Colors.white, BlendMode.srcIn) : null,
          ),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}