

import '../models.dart';
import 'package:flutter/material.dart'; // <-- Add this import for IconData


class MockDataService {
  // Hard-coded categories from the original app
  final List<String> categories = [
    "Restaurants",
    "Bars",
    "Coffee",
    "Entertainment",
    "Outdoor",
    "Shopping",
  ];

  // Hard-coded list of mock friends
   final List<OutingUser> _friends = [
    OutingUser(uid: 'friend1', displayName: 'Alex Ray', email: 'alex@example.com', streak: 25, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend2', displayName: 'Mia Wong', email: 'mia@example.com', streak: 18, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend3', displayName: 'Leo Chen', email: 'leo@example.com', streak: 5, photoUrl: 'placeholder'),
    OutingUser(uid: 'friend4', displayName: 'Zoe Garcia', email: 'zoe@example.com', streak: 31, photoUrl: 'placeholder'),
  ];
  final List<Game> _games = [
    Game(id: 'g1', title: 'Photo Scavenger Hunt', description: 'Complete photo challenges with friends.', icon: Icons.camera_alt),
    Game(id: 'g2', title: 'Local Trivia', description: 'Test your knowledge about your city.', icon: Icons.quiz),
    Game(id: 'g3', title: 'Outing Bingo', description: 'Complete a bingo card of fun activities.', icon: Icons.grid_on),
    Game(id: 'g4', title: 'Dare Drop', description: 'Challenge your friends to hilarious dares.', icon: Icons.local_fire_department),
  ];
  // Hard-coded list of venues from the original app
  final List<Venue> _venues = [
    Venue(
      id: '1',
      name: "The Rooftop Lounge",
      type: "Bar & Grill",
      rating: 4.5,
      distance: "0.8 km",
      price: "\$\$\$",
      status: "Open",
      tags: ["Trendy", "Lively"],
      image: "placeholder",
    ),
    Venue(
      id: '2',
      name: "Cozy Corner Cafe",
      type: "Coffee Shop",
      rating: 4.2,
      distance: "1.2 km",
      price: "\$\$",
      status: "Open",
      tags: ["Quiet", "Cozy"],
      image: "placeholder",
    ),
    Venue(
      id: '3',
      name: "Adventure Bowling",
      type: "Entertainment",
      rating: 4.7,
      distance: "2.1 km",
      price: "\$\$",
      status: "Closed",
      tags: ["Family-Friendly", "Fun"],
      image: "placeholder",
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
    return _friends;
  }
Future<List<Game>> getGames() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return _games;
  }
}

