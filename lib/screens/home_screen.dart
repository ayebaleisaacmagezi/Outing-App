// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../main.dart' show AppColors;
import 'discover_screen.dart';
import 'friends_screen.dart';
import 'profile_screen.dart';
import 'games_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<Widget> _screens = <Widget>[
    DiscoverScreen(),
    FriendsScreen(),
    GamesScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<AppNavProvider>(
      builder: (context, navProvider, child) {
        return Scaffold(
          body: IndexedStack(
            index: navProvider.selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navProvider.selectedIndex,
            onTap: (index) => navProvider.selectedIndex = index,
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.darkPrimary.withOpacity(0.95),
            selectedItemColor: AppColors.electricCyan,
            unselectedItemColor: Colors.grey[600],
            showUnselectedLabels: true,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.explore_outlined), label: 'Discover'),
              BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Friends'),
              BottomNavigationBarItem(icon: Icon(Icons.sports_esports_outlined), label: 'Games'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}