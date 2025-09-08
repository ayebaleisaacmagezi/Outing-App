import '../models.dart';
import 'package:flutter/material.dart'; // <-- Add this import for IconData


class MockDataService {
  // Hard-coded categories from the original app
  final List<String> categories = [
    "Restaurants",
    "Bars",
    "Events",
    "Entertainment",
    "Near You",
  ];

  // Hard-coded list of mock friends
   final List<OutingUser> _allUsersInApp = [
    OutingUser(uid: 'friend1', displayName: 'Alex Ray', email: 'alex@example.com', streak: 25, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend2', displayName: 'Mia Wong', email: 'mia@example.com', streak: 18, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend3', displayName: 'Leo Chen', email: 'leo@example.com', streak: 5, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend4', displayName: 'Zoe Garcia', email: 'zoe@example.com', streak: 31, photoUrl: 'placeholder'),
    OutingUser(uid: 'req1', displayName: 'Casey Becker', email: 'casey@example.com', streak: 0, photoUrl: 'placeholder'),
    OutingUser(uid: 'req2', displayName: 'David Reed', email: 'david@example.com', streak: 0, photoUrl: 'placeholder'),
  ];
  final List<Game> _games = [
    Game(id: 'g1', title: 'Photo Scavenger Hunt', description: 'Complete photo challenges with friends.', icon: Icons.camera_alt),
    Game(id: 'g2', title: 'Local Trivia', description: 'Test your knowledge about your city.', icon: Icons.quiz),
    Game(id: 'g3', title: 'Outing Bingo', description: 'Complete a bingo card of fun activities.', icon: Icons.grid_on),
    Game(id: 'g4', title: 'Dare Drop', description: 'Challenge your friends to hilarious dares.', icon: Icons.local_fire_department),
  ];

  List<OutingUser> _myFriends = [];
  List<OutingUser> _myFriendRequests = [];

  MockDataService() {
    // Initialize the data when the service is created
    _myFriends = _allUsersInApp.sublist(0, 2); // Start with Alex and Mia as friends
    _myFriendRequests = _allUsersInApp.sublist(4, 6); // Casey and David are friend requests
  }

  // Hard-coded list of venues from the original app
  final List<Venue> _venues = [
    Venue(
      id: '1',
      name: "Yums Cafe",
      type: "Restaurant",
      rating: 4.5,
      latitude: 37.7749,  // <-- ADD THIS
      longitude: -122.4194,
      price: "\$\$\$",
      status: "Open",
      tags: ["Trendy", "Lively"],
      image: "placeholder",
      category: "Restaurants", 
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
    Venue(
      id: '2',
      name: "Asian Fusion Restaurant",
      type: "Asian Cuisine",
      rating: 4.2,
      latitude: 37.7858,  // <-- ADD THIS
      longitude: -122.4011, 
      price: "\$\$",
      status: "Open",
      tags: ["Quiet", "Cozy"],
      image: "placeholder",
      category: "Restaurants",
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
    Venue(
      id: '3',
      name: "Century Cinemax",
      type: "Entertainment",
      rating: 4.7,
      latitude: 37.7725,  // <-- ADD THIS
      longitude: -122.4313,
      price: "\$\$",
      status: "Closed",
      tags: ["Family-Friendly", "Fun"],
      image: "placeholder",
      category: "Entertainment",
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
     Venue(
      id: '4',
      name: "National Theatre",
      type: "Entertainment",
      rating: 4.7,
      latitude: 37.7725,  // <-- ADD THIS
      longitude: -122.4313,
      price: "\$\$",
      status: "Closed",
      tags: ["Family-Friendly", "Fun"],
      image: "placeholder",
      category: "Entertainment",
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
        Venue(
      id: '5',
      name: "The Bourbon",
      type: "Entertainment",
      rating: 4.7,
      latitude: 37.7725,  // <-- ADD THIS
      longitude: -122.4313,
      price: "\$\$",
      status: "Closed",
      tags: ["Family-Friendly", "Fun"],
      image: "placeholder",
      category: "Bars",
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
        Venue(
      id: '6',
      name: "Ninety9 By The Embers",
      type: "Nightlife",
      rating: 4.7,
      latitude: 37.7725,  // <-- ADD THIS
      longitude: -122.4313,
      price: "\$\$",
      status: "Closed",
      tags: ["Family-Friendly", "Fun"],
      image: "placeholder",
      category: "Bars",
      websiteUrl: 'https://example.com',
      instagramUrl: 'https://instagram.com/example',
      phoneNumber: '+1234567890',
      whatsappNumber: '+1234567890',
    ),
  ];

  // Hard-coded mock user
  final OutingUser _currentUser = OutingUser(
    uid: 'user123',
    displayName: 'Shem remo',
    email: 'shem.remo@example.com',
    streak: 12,
    photoUrl: 'placeholder',
  );


  // A method to simulate fetching venues from a network
  Future<List<Venue>> getVenues() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _venues;
  }

  // A method to simulate fetching user data
  Future<OutingUser> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _currentUser;
  }

  Future<List<OutingUser>> getFriends() async {
    await Future.delayed(const Duration(milliseconds: 600));
    return List.from(_myFriends);
  }

  Future<List<OutingUser>> getFriendRequests() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return List.from(_myFriendRequests); // Return only the last two users as friend requests

  }
  Future<List<OutingUser>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (query.isEmpty) {
      return [];
    }
    final existingIds = {..._myFriends.map((u) => u.uid), ..._myFriendRequests.map((u) => u.uid)};
    return _allUsersInApp.where((user) {
        final isExisting = existingIds.contains(user.uid);
      final matchesQuery = user.displayName.toLowerCase().contains(query.toLowerCase());
      return !isExisting && matchesQuery;
    }).toList();
  }

  // Simulates sending a friend request. In a real app, this would write to Firestore.
  Future<void> sendFriendRequest(OutingUser user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("Simulating: Sent friend request to ${user.displayName}.");
  }

  // Simulates accepting a friend request by moving a user from one list to another.
  Future<void> acceptFriendRequest(OutingUser user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _myFriendRequests.removeWhere((u) => u.uid == user.uid);
    if (!_myFriends.any((u) => u.uid == user.uid)) {
      _myFriends.add(user);
    }
    print("Simulating: Accepted friend request from ${user.displayName}.");
  }

  // Simulates declining a friend request by removing the user from the requests list.
  Future<void> declineFriendRequest(OutingUser user) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _myFriendRequests.removeWhere((u) => u.uid == user.uid);
    print("Simulating: Declined friend request from ${user.displayName}.");
  }


  Future<List<Game>> getGames() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _games;
  }
}

