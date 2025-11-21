import 'package:flutter/material.dart';

class Venue {
  final String id;
  final String name;
  final String type;
  final double rating;
  final double latitude;
  final double longitude;
  final String price;
  final String status;
  final List<String> tags;
  final String image;
  final String category;
  final String? websiteUrl;
  final String? instagramUrl;
  final String? phoneNumber;
  final String? tiktok;
  final bool isFavorite;

  Venue({
    required this.id,
    required this.name,
    required this.type,
    required this.rating,
    required this.latitude,   // <-- ADD THIS
    required this.longitude,
    required this.price,
    required this.status,
    required this.tags,
    required this.image,
    required this.category,
    this.websiteUrl,
    this.instagramUrl,
    this.phoneNumber,
    this.tiktok,
    this.isFavorite = false,
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