// lib/screens/auth/auth_gate.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../home_screen.dart';
import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        // Listen to the authentication state changes from Firebase
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // 1. If the snapshot is still waiting for data, show a loading indicator
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. If the snapshot has data, it means the user is logged in
          if (snapshot.hasData) {
            // Show the main app screen (HomeScreen)
            return const HomeScreen();
          }

          // 3. If the snapshot has no data, the user is not logged in
          else {
            // Show the LoginScreen
            return const LoginScreen();
          }
        },
      ),
    );
  }
}