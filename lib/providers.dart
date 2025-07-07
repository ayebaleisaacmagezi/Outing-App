// lib/providers.dart

import 'package:flutter/material.dart';
import 'models.dart';
import 'services/mock_data_service.dart';

// Provider to manage the selected index of the BottomNavigationBar
class AppNavProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners(); // This tells the UI to rebuild
  }
}

// Provider for the Discover Screen's state
class DiscoverProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();

  late List<String> _categories;
  List<Venue> _venues = [];
  String _activeCategory = "Restaurants";
  bool _isLoading = false;

  // Public getters
  List<String> get categories => _categories;
  List<Venue> get venues => _venues;
  String get activeCategory => _activeCategory;
  bool get isLoading => _isLoading;

  DiscoverProvider() {
    // When the provider is created, get the initial data
    _categories = _mockDataService.categories;
    fetchVenues();
  }
  
  // Method to fetch data from our mock service
  Future<void> fetchVenues() async {
    _isLoading = true;
    notifyListeners();

    _venues = await _mockDataService.getVenues();

    _isLoading = false;
    notifyListeners();
  }

  // Method to update the active category
  void selectCategory(String category) {
    _activeCategory = category;
    notifyListeners();
    // In a real app, you might re-fetch venues based on the new category here
  }
} // <--- THIS BRACE WAS MISPLACED

// Provider for the Profile Screen's state
class ProfileProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();

  OutingUser? _user;
  bool _isLoading = false;

  OutingUser? get user => _user;
  bool get isLoading => _isLoading;

  ProfileProvider() {
    fetchUser();
  }

  Future<void> fetchUser() async {
    _isLoading = true;
    notifyListeners();

    _user = await _mockDataService.getCurrentUser();

    _isLoading = false;
    notifyListeners();
  }
}

// Provider for the Friends Screen's state
class FriendsProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();

  List<OutingUser> _friends = [];
  bool _isLoading = false;
  String _searchQuery = '';

  List<OutingUser> get friends {
    // Filter friends based on the search query
    if (_searchQuery.isEmpty) {
      return _friends;
    } else {
      return _friends
          .where((friend) =>
              friend.displayName.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }
  }

  bool get isLoading => _isLoading;

  FriendsProvider() {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    _isLoading = true;
    notifyListeners();
    _friends = await _mockDataService.getFriends();
    _isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}

class GameProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();

  List<Game> _games = [];
  bool _isLoading = false;

  List<Game> get games => _games;
  bool get isLoading => _isLoading;

  GameProvider() {
    fetchGames();
  }

  Future<void> fetchGames() async {
    _isLoading = true;
    notifyListeners();
    _games = await _mockDataService.getGames();
    _isLoading = false;
    notifyListeners();
  }
}