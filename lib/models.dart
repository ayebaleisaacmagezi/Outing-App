import 'package:flutter/material.dart'; // <-- ADD THIS IMPORT

class Venue {
  final String id;
  final String name;
  final String type;
  final double rating;
  final String distance;
  final String price;
  final String status;
  final List<String> tags;
  final String image;

  Venue({
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    required this.distance,
    required this.price,
    required this.status,
    required this.tags,
    required this.image,
  });
}

class OutingUser {
  final String uid;
  final String displayName;
  final String email;
  final int streak;
  final String photoUrl;
  
  OutingUser({
    required this.uid,
    required this.displayName,
    required this.email,
    required this.streak,
    required this.photoUrl,
  });
}
class Game {
  final String id;
  final String title;
  final String description;
  final IconData icon;

  Game({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}