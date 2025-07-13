// lib/widgets/venue_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import '../main.dart' show AppColors, AppGradients;
import '../models.dart';
import 'tag_badge.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;
  final Position? currentPosition;

  const VenueCard({
    super.key,
    required this.venue,
    this.currentPosition,
  });

  String _getFormattedDistance() {
    if (currentPosition == null) return '';
    final distanceInMeters = Geolocator.distanceBetween(
      currentPosition!.latitude,
      currentPosition!.longitude,
      venue.latitude,
      venue.longitude,
    );
    return '${(distanceInMeters / 1000).toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    final bool isOpen = venue.status == 'Open';
    final statusColor = isOpen ? AppColors.auroraGreen : AppColors.statusRed;
    final String displayDistance = _getFormattedDistance();

    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        gradient: AppGradients.card,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: AppColors.electricCyan.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.1),
            blurRadius: 15,
            spreadRadius: 1,
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
                color: AppColors.darkSecondary,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(color: AppColors.electricCyan.withOpacity(0.2)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SvgPicture.asset(
                  'assets/images/placeholder.svg',
                  colorFilter:
                      const ColorFilter.mode(AppColors.electricCyan, BlendMode.srcIn),
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
                            Text(venue.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                    color: Colors.white)),
                            const SizedBox(height: 2),
                            Text(venue.type,
                                style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.star,
                              color: AppColors.sunsetOrange, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            venue.rating.toString(),
                            style: const TextStyle(
                                color: AppColors.sunsetOrange,
                                fontWeight: FontWeight.w600,
                                fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (displayDistance.isNotEmpty) ...[
                        Text(displayDistance, style: TextStyle(color: Colors.grey[400])),
                        const SizedBox(width: 16),
                      ],
                      Text(venue.price, style: TextStyle(color: Colors.grey[400])),
                      const Spacer(),
                      TagBadge(
                        text: venue.status,
                        icon: Icons.access_time,
                        color: statusColor,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: venue.tags
                        .map((tag) => TagBadge(
                              text: tag,
                              color: AppColors.neonPurple,
                            ))
                        .toList(),
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