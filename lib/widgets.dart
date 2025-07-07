// lib/widgets.dart
import 'package:flutter/material.dart';
import '../models.dart';
import '../main.dart' show AppColors;

class VenueCard extends StatelessWidget {
  final Venue venue;

  const VenueCard({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = venue.status == 'Open';
    
    const cardGradient = LinearGradient(
      colors: [
        AppColors.darkSecondary,
        Color(0xFF16213E),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        gradient: cardGradient,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: AppColors.electricCyan.withAlpha(51)), // CORRECTED
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withAlpha(26), // CORRECTED
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: const Color(0xFF16213E),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: AppColors.electricCyan.withAlpha(51)), // CORRECTED
              ),
              child: Center(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    gradient: const LinearGradient(
                      colors: [AppColors.neonPurple, AppColors.electricCyan],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(venue.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text(venue.type, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star, color: AppColors.sunsetOrange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            venue.rating.toString(),
                            style: const TextStyle(color: AppColors.sunsetOrange, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(venue.distance, style: TextStyle(color: Colors.grey[400])),
                      const SizedBox(width: 12),
                      Text(venue.price, style: TextStyle(color: Colors.grey[400])),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (isOpen ? AppColors.auroraGreen : AppColors.statusRed).withAlpha(51), // CORRECTED
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: (isOpen ? AppColors.auroraGreen : AppColors.statusRed).withAlpha(77)), // CORRECTED
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.access_time, size: 12, color: isOpen ? AppColors.auroraGreen : AppColors.statusRed),
                            const SizedBox(width: 4),
                            Text(venue.status, style: TextStyle(fontSize: 12, color: isOpen ? AppColors.auroraGreen : AppColors.statusRed)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: venue.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Gradient gradient;
  final double borderRadius;

  const GradientButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 8.0,
    this.gradient = const LinearGradient(
      colors: [AppColors.neonPurple, AppColors.electricCyan],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withAlpha(102), // CORRECTED
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: child,
      ),
    );
  }
}

class FriendListItem extends StatelessWidget {
  final OutingUser friend;
  const FriendListItem({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.darkSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.darkPrimary,
            child: Icon(Icons.person, color: AppColors.electricCyan),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              friend.displayName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Invite'),
          ),
        ],
      ),
    );
  }
}