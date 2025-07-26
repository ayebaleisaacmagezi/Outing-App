// lib/screens/auth/login_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'signup_screen.dart';
import '../../services/auth_service.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/auth_social_button.dart';
import '../../widgets/glow_button.dart';
import '../home_screen.dart'; 
import '../../main.dart' show AppGradients;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  bool _isLoading = false;

   @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Method to handle the login logic
  void _handleLogin() async {
    print("--- LOGIN BUTTON TAPPED ---");
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() { _isLoading = true; });

    // Call the sign-in method from our service
    final user = await _authService.signInWithEmailAndPassword(email, password);

    setState(() { _isLoading = false; });

    if (user != null && mounted) {
      // If login is successful, navigate to the HomeScreen
      print("Login successful! User: ${user.uid}");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false, // This removes auth screens from back stack
      );
    } else {
      // If login fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed. Please check your credentials.')),
      );
    }
  }

   void _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _authService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user != null && mounted) {
      print("Google Sign-In successful! User: ${user.uid}");
      // The AuthGate will handle navigation automatically, but we can
      // push a new route just in case.
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false,
      );
    } else if (mounted) {
      // Handle the case where the user cancels the sign-in flow
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Google Sign-In was cancelled or failed.')),
      );
    }
  }


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
          CustomTextField(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.alternate_email,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _passwordController,
            hintText: 'Password',
            icon: Icons.lock_outline,
            isPassword: true,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: double.infinity,
            child: GlowButton(
              onPressed: _handleLogin,
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
                  onPressed: _isLoading ? () {} : _handleGoogleSignIn,
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