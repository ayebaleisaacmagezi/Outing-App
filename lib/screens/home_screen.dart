// lib/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../main.dart' show AppColors; // Import our custom colors
import 'discover_screen.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';
import 'games_screen.dart'; // We'll use this for the "Games" tab for now

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // A list of the screens to be displayed
  static const List<Widget> _screens = <Widget>[
    DiscoverScreen(),
    FriendsScreen(),
    GamesScreen(), // Placeholder for Games
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    // Use a Consumer to listen for changes in the AppNavProvider
    return Consumer<AppNavProvider>(
      builder: (context, navProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: navProvider.selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navProvider.selectedIndex,
            onTap: (index) {
              // Update the state when a tab is tapped
              navProvider.selectedIndex = index;
            },
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.darkPrimary.withOpacity(0.95),
            selectedItemColor: AppColors.electricCyan,
            unselectedItemColor: Colors.grey[600],
            showUnselectedLabels: true,
            // --- MODIFIED ICONS ---
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.explore_outlined),
                activeIcon: Icon(Icons.explore), // Optional: show filled icon when active
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.group_outlined),
                activeIcon: Icon(Icons.group),
                label: 'Friends',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.sports_esports_outlined),
                activeIcon: Icon(Icons.sports_esports),
                label: 'Games',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}