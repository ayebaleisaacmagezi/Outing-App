// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_screen.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_social_button.dart';
import '../../widgets/glow_button.dart';
import '../../main.dart' show AppGradients;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Welcome Back',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Log in to continue your adventure',
            style: TextStyle(
              color: Colors.grey[400],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 40),
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
              child: const Text('Login'),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Expanded(
                  child: Divider(color: Colors.grey[800], thickness: 1)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text('Or continue with',
                    style: TextStyle(color: Colors.grey[500])),
              ),
              Expanded(
                  child: Divider(color: Colors.grey[800], thickness: 1)),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              Expanded(
                child: AuthSocialButton(
                  onPressed: () {},
                  iconPath: 'assets/images/google_logo.svg',
                  label: 'Google',
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AuthSocialButton(
                  onPressed: () {},
                  iconPath: 'assets/images/apple_logo.svg',
                  label: 'Apple',
                  isSvgDark: true,
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account? ",
                  style: TextStyle(color: Colors.grey[400])),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ));
                },
                child: const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}