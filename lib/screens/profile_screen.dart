// lib/screens/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../main.dart' show AppColors;
import '../services/auth_service.dart'; // <-- 1. IMPORT AuthService
import 'auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading || provider.user == null) {
            return const Center(child: CircularProgressIndicator());
          }
           if (provider.user == null) {
            return const Center(
              child: Text(
                'Not logged in.',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            );
          }
          final user = provider.user!;

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            children: [
              const SizedBox(height: 20),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.electricCyan, width: 3),
                    ),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: AppColors.darkSecondary,
                      // Using a placeholder image or icon
                      child: user.photoUrl == 'placeholder'
                          ? const Icon(Icons.person, size: 50, color: AppColors.electricCyan)
                          : ClipOval(child: Image.network(user.photoUrl, fit: BoxFit.cover)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(user.displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(user.email, style: const TextStyle(fontSize: 16, color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 30),
              _buildMenuList(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMenuList(BuildContext context) {
    final AuthService authService = AuthService();
    return Container(
      decoration: BoxDecoration(
        color: AppColors.darkSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildMenuItem(
            icon: Icons.edit_outlined,
            text: 'Edit Profile',
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.darkPrimary),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            text: 'Settings',
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.darkPrimary),
          _buildMenuItem(
            icon: Icons.help_outline,
            text: 'Help & Support',
            onTap: () {},
          ),
          const Divider(height: 1, color: AppColors.darkPrimary),
          _buildMenuItem(
            icon: Icons.logout,
            text: 'Log Out',
            color: AppColors.sunsetOrange,
            onTap: ()async {
              await authService.signOut();
              if (context.mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.white70),
      title: Text(text, style: TextStyle(color: color ?? Colors.white, fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 16, color: color ?? Colors.white70),
      onTap: onTap,
    );
  }
}