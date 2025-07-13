// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // <-- 1. IMPORT
import 'firebase_options.dart';
import 'providers.dart';
import 'screens/auth/login_screen.dart'; // Start with Sign Up Screen

Future<void> main() async {
  // 4. INITIALIZE WIDGETS AND FIREBASE
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppNavProvider()),
        ChangeNotifierProvider(create: (_) => DiscoverProvider()),
        ChangeNotifierProvider(create: (_) => GameProvider()),
        ChangeNotifierProvider(create: (_) => FriendsProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const OutingApp(),
    ),
  );
}

// App Colors
class AppColors {
  static const Color darkPrimary = Color(0xFF0A0A0F);
  static const Color darkSecondary = Color(0xFF1A1A2E);
  static const Color electricCyan = Color(0xFF00F5FF);
  static const Color neonPurple = Color(0xFF8B5CF6);
  static const Color auroraGreen = Color(0xFF10B981);
  static const Color sunsetOrange = Color(0xFFF59E0B);
  static const Color statusRed = Color(0xFFEF4444);
  static const Color cosmicPurple = Color(0xFF2D1B69);
}

// App Gradients
class AppGradients {
  static const LinearGradient aurora = LinearGradient(
    colors: [AppColors.neonPurple, AppColors.electricCyan],
  );
  static const LinearGradient card = LinearGradient(
    colors: [AppColors.darkSecondary, Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient cosmic = LinearGradient(
    colors: [AppColors.darkPrimary, AppColors.darkSecondary, Color(0xFF16213E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// Main App Widget
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
        textTheme: ThemeData.dark().textTheme.apply(fontFamily: 'Arial'),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: AppColors.darkSecondary.withOpacity(0.5),
          hintStyle: TextStyle(color: Colors.grey[400]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: AppColors.electricCyan.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(color: AppColors.electricCyan.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: const BorderSide(color: AppColors.electricCyan),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: AppColors.neonPurple.withOpacity(0.1),
          labelStyle: const TextStyle(
              color: AppColors.neonPurple, fontSize: 12, fontWeight: FontWeight.w500),
          side: BorderSide(color: AppColors.neonPurple.withOpacity(0.3)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.darkPrimary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.electricCyan,
            side: BorderSide(color: AppColors.electricCyan.withOpacity(0.3)),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}