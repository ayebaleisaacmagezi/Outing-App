import 'package:flutter/material.dart';
import '../main.dart' show AppGradients; // Correct import

class AuthScaffold extends StatelessWidget {
  final Widget child;
  const AuthScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppGradients.cosmic,
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
              child: Column(
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) =>
                        AppGradients.aurora.createShader(bounds),
                    child: const Text(
                      'OutingApp',
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                  child,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}