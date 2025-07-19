// lib/screens/auth/signup_screen.dart
import 'package:flutter/material.dart';
import '../../services/auth_service.dart';
import '../../widgets/auth_scaffold.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/glow_button.dart';
import '../home_screen.dart'; 
import '../../main.dart' show AppGradients;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // 2. CREATE controllers to get text from fields
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController(); // For the phone field

  // Instantiate our AuthService
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    // Clean up the controllers when the widget is removed
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  
  // 3. CREATE the sign-up handler method
  void _handleSignUp() async {
    // Get the values from the controllers
    String displayName = _displayNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text;

    // Basic validation
    if (displayName.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // Call the service to sign up the user
    final user = await _authService.signUpWithEmailAndPassword(email, password, displayName);

    if (user != null) {
      // If sign up is successful, navigate to the HomeScreen
      print("Sign up successful! User: ${user.displayName}");
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
        (route) => false, // This removes all previous routes
      );
    } else {
      // If sign up fails, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up failed. Please try again.')),
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
          CustomTextField(
            controller: _displayNameController,
            hintText: 'User Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 20),
          CustomTextField(
            controller: _phoneController, 
            hintText: 'Phone Number',
            icon: Icons.phone_outlined, // A suitable icon for a phone number
          ),
          const SizedBox(height: 20),
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
              onPressed: _handleSignUp,
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