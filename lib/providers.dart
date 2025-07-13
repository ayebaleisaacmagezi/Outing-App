// lib/providers.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'models.dart';
import 'services/mock_data_service.dart';
import 'package:geolocator/geolocator.dart';

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
  static const double _nearYouRadiusMeters = 15079500; // in metres radius for "Near You"
  // This is a large radius to simulate "Near You" for testing purposes.

  late List<String> _categories;
  List<Venue> _allVenues = []; 
  List<Venue> _venues = [];
  String _activeCategory = "Near You";
  bool _isLoading = false;
  Position? _currentPosition;

  // Public getters
  List<String> get categories => _categories;
  List<Venue> get venues => _venues;
  String get activeCategory => _activeCategory;
  bool get isLoading => _isLoading;
  Position? get currentPosition => _currentPosition; 

  DiscoverProvider() {
    // When the provider is created, get the initial data
    _categories = _mockDataService.categories; // This line is the problem
  fetchVenues();
    _initializeDiscoverFeed();
  }

  // New initialization flow
  Future<void> _initializeDiscoverFeed() async {
    _isLoading = true;
    notifyListeners();
    
    // First, get location, then fetch venues and filter.
    await _handleLocationPermission();
    _allVenues = await _mockDataService.getVenues();
    _filterVenues();
    
    _isLoading = false;
    notifyListeners();
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

  // Method to fetch data from our mock service
  Future<void> fetchVenues() async {
    _isLoading = true;
    notifyListeners();

    _allVenues = await _mockDataService.getVenues();
    _filterVenues();

    _isLoading = false;
    notifyListeners();
  }

  // Method to update the active category
  void selectCategory(String category) {
      if (_activeCategory != category) {
        _activeCategory = category;
        _filterVenues(); // Re-filter the list with the new category
        notifyListeners();
     }
    // In a real app, you might re-fetch venues based on the new category here
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