// lib/providers.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'models.dart';
import '../services/auth_service.dart'; 
import 'services/mock_data_service.dart';
import 'package:geolocator/geolocator.dart';

// Provider to manage the selected index of the BottomNavigationBar
class AppNavProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int index) {
     if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }
}

// Provider for the Discover Screen's state
class DiscoverProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();
  static const double _nearYouRadiusMeters = 15079400; // in metres radius for "Near You"
  // This is a large radius to simulate "Near You" for testing purposes.

  List<String> _categories = [];
  List<Venue> _allVenues = [];
  List<Venue> _venues = [];
  String _activeCategory = "Near You";
  bool _isLoading = false;
  Position? _currentPosition;

  // Secondary Filter State
  List<String> _selectedBudgets = []; // Can hold multiple values, e.g., ["$", "$$"]
  bool _sortByPopularity = false;

   // --- GETTERS ---
  List<Venue> get venues => _venues;
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition;
  String get activeCategory => _activeCategory;

   // Getters for the Filters sheet UI
  List<String> get selectedBudgets => _selectedBudgets;
  bool get sortByPopularity => _sortByPopularity;

   // Static lists for UI options
  final List<String> primaryCategories = ["Near You", "Restaurants", "Bars", "Coffee", "Entertainment"];
  final List<String> allBudgets = ["\$", "\$\$", "\$\$\$"];


  DiscoverProvider() {
    // When the provider is created, get the initial data
    _categories = _mockDataService.categories; // This line is the problem
    _initializeDiscoverFeed();
  }

  // New initialization flow
  Future<void> _initializeDiscoverFeed() async {
    _isLoading = true;
    notifyListeners();
    
    // First, get location, then fetch venues and filter.
    await _handleLocationPermission();
    _allVenues = await _mockDataService.getVenues();
    _applyFilters();

    _isLoading = false;
    notifyListeners();
  }
  
  // Method to update the active category
  void selectCategory(String category) {
      if (_activeCategory != category) {
        _activeCategory = category;
        _applyFilters();// Re-filter the list with the new category
        notifyListeners();
     }
    // In a real app, you might re-fetch venues based on the new category here
    }
  
   // For Secondary Budget Filter (multi-select)
  void toggleBudget(String budget) {
    if (_selectedBudgets.contains(budget)) {
      _selectedBudgets.remove(budget);
    } else {
      _selectedBudgets.add(budget);
    }
    _applyFilters();
    notifyListeners();
  }

  // For Secondary Popularity Filter
  void toggleSortByPopularity() {
    _sortByPopularity = !_sortByPopularity;
    _applyFilters();
    notifyListeners();
  }

  void clearSecondaryFilters() {
    _selectedBudgets.clear();
    _sortByPopularity = false;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    List<Venue> filtered = List.from(_allVenues);

    // 1. Apply PRIMARY filter first
    if (_activeCategory == "Near You") {
      if (_currentPosition != null) {
        filtered = filtered.where((v) {
          final distance = Geolocator.distanceBetween(_currentPosition!.latitude, _currentPosition!.longitude, v.latitude, v.longitude);
          return distance <= _nearYouRadiusMeters;
        }).toList();
      }
    } else {
      filtered = filtered.where((v) => v.category == _activeCategory).toList();
    }

    // 2. Apply SECONDARY filters on the already filtered list
    
    // Budget filter (if any budgets are selected)
    if (_selectedBudgets.isNotEmpty) {
      filtered = filtered.where((v) => _selectedBudgets.contains(v.price)).toList();
    }
    
    // Popularity sort
    if (_sortByPopularity) {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }
    
    _venues = filtered;
  }

  void _filterVenues() {
    if (_activeCategory == "Near You") {
      if (_currentPosition != null) {
        // We have a location, so filter by distance.
        _venues = _allVenues.where((venue) {
          final distance = Geolocator.distanceBetween(
            _currentPosition!.latitude,
            _currentPosition!.longitude,
            venue.latitude,
            venue.longitude,
          );
          return distance <= _nearYouRadiusMeters;
        }).toList();
      } else {
        // No location, so "Near You" shows nothing or everything.
        // Showing all is a safe fallback.
        _venues = _allVenues;
      }
    } else {
      // Standard category filtering.
      _venues = _allVenues
      .where((venue) => venue.category == _activeCategory)
      .toList();
  }
  }


   // Handles all location permission logic.
  Future<void> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied.
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are permanently denied.
      return;
    }

    // When we reach here, permissions are granted.
    _currentPosition = await Geolocator.getCurrentPosition();
  }


} // <--- THIS BRACE WAS MISPLACED

// Provider for the Profile Screen's state
class ProfileProvider with ChangeNotifier {
  final AuthService _authService = AuthService();

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

    final firebaseUser = _authService.currentUser;
     if (firebaseUser != null) {
      // 3. If a user is logged in, convert the Firebase User object
      //    into our app's OutingUser model.
      _user = OutingUser(
        uid: firebaseUser.uid,
        displayName: firebaseUser.displayName ?? 'No Name', // Provide a fallback
        email: firebaseUser.email ?? 'No Email', // Provide a fallback
        streak: 12, // This is still mock data for now
        photoUrl: firebaseUser.photoURL ?? 'placeholder', // Get the real photo URL if it exists
      );
    } else {
      // If no user is logged in, set our user to null
      _user = null;
    }

    _isLoading = false;
    notifyListeners();
  }
}

// Provider for the Friends Screen's state
class FriendsProvider with ChangeNotifier {
  final MockDataService _mockDataService = MockDataService();

  List<OutingUser> _allFriends = [];
  List<OutingUser> _displayedFriends = [];
  List<OutingUser> _friendRequests = [];
  bool _isLoading = false;
  
  List<OutingUser> _searchResults = [];
  bool _isSearching = false;

  List<OutingUser> get friends => _displayedFriends;
  List<OutingUser> get allFriends => _allFriends;
  List<OutingUser> get friendRequests => _friendRequests;
  bool get isLoading => _isLoading;
  List<OutingUser> get searchResults => _searchResults;
  bool get isSearching => _isSearching;

  FriendsProvider() {
    fetchFriends();
  }

  Future<void> fetchFriends() async {
   _isLoading = true;
    notifyListeners();
    _allFriends = await _mockDataService.getFriends();
    _friendRequests =  await _mockDataService.getFriendRequests();
    _displayedFriends = _allFriends;
    _isLoading = false;
    notifyListeners();
  }
  
  // Searches your EXISTING friends list on the main FriendsScreen
  void searchMyFriends(String query) {
    if (query.isEmpty) {
      _displayedFriends = _allFriends;
    } else {
      _displayedFriends = _allFriends
          .where((friend) =>
              friend.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

   // THIS IS THE ONLY SEARCH METHOD WE NEED NOW
  Future<void> searchAllUsers(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      _isSearching = false;
      notifyListeners();
      return;
    }

    _isSearching = true;
    notifyListeners();

    // In a real app, this would be a Firestore query.
    _searchResults = await _mockDataService.searchUsers(query);
    
    _isSearching = false;
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
    await Future.delayed(const Duration(milliseconds: 400));
    _games = [Game(
        id: '1',
        title: 'Trivia Night',
        description: 'Test your knowledge against friends.',
        icon: Icons.question_answer_outlined,
      ),
      Game(
        id: '2',
        title: '2 Truths 1 Lie',
        description: 'Can you spot the fibber?',
        icon: Icons.record_voice_over_outlined,
      ),
      Game(
        id: '3',
        title: 'Outing Roulette',
        description: 'Spin the wheel to pick a place.',
        icon: Icons.casino_outlined,
      ),
      Game(
        id: '4',
        title: 'City Scavenger Hunt',
        description: 'Complete challenges around town.',
        icon: Icons.location_on_outlined,
      ),
    ];
    _isLoading = false;
    notifyListeners();
  }
}