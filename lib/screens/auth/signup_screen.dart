// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/glow_button.dart';
import '../../main.dart' show AppGradients;

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Create Account',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start your journey with us today',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
          const CustomTextField(
            hintText: 'User Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            hintText: 'Phone Number',
            icon: Icons.phone_outlined, // A suitable icon for a phone number
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            hintText: 'Email',
            icon: Icons.alternate_email,
          ),
          const SizedBox(height: 20),
          const CustomTextField(
            hintText: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: GlowButton(
              onPressed: () {},
              gradient: AppGradients.aurora,
              child: const Text('Create Account'),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account? ",
                  style: TextStyle(color: Colors.grey[400])),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}