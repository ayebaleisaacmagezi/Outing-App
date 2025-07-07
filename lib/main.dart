// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNavProvider()),
        ChangeNotifierProvider(create: (_) => DiscoverProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => FriendsProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()), 

      ],
      child: const OutingApp(),
    ),
  );
}


class AppColors {
  static const Color darkPrimary = Color(0xFF0A0A0F);
  static const Color darkSecondary = Color(0xFF1A1A2E);
  static const Color electricCyan = Color(0xFF00F5FF);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color auroraGreen = Color(0xFF10B981);
  static const Color sunsetOrange = Color(0xFFF59E0B);
  static const Color statusRed = Color(0xFFEF4444);
  static const Color cosmic_purple = Color(0xFF2D1B69); 

}

class OutingApp extends StatelessWidget {
  const OutingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OutingApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: AppColors.darkPrimary,
        primaryColor: AppColors.electricCyan,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSecondary.withAlpha(128), // CORRECTED
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(color: AppColors.electricCyan.withAlpha(77)), // CORRECTED
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: AppColors.electricCyan),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.neonPurple.withAlpha(26), // CORRECTED
          labelStyle: const TextStyle(color: AppColors.neonPurple, fontSize: 12),
          side: BorderSide(color: AppColors.neonPurple.withAlpha(77)), // CORRECTED
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
            backgroundColor: AppColors.electricCyan,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.electricCyan,
            side: BorderSide(color: AppColors.electricCyan.withAlpha(77)), // CORRECTED
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}