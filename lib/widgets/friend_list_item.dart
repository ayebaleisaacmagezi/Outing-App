// lib/widgets/friend_list_item.dart
import 'package:flutter/material.dart';
import '../main.dart' show AppColors;
import '../models.dart';

class FriendListItem extends StatelessWidget {
  final OutingUser friend;
  final bool isRequest; 
  const FriendListItem({super.key, required this.friend, this.isRequest = false});

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
            child: Icon(Icons.person, color: AppColors.electricCyan), // <-- CORRECTED
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              friend.displayName,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          const SizedBox(width: 16),
          if (isRequest)
            _buildRequestButtons()
          else
            _buildFriendButtons(),
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

   Widget _buildFriendButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.chat_bubble_outline, color: Colors.white70),
          onPressed: () { /* TODO: Open chat */ },
        ),
        IconButton(
          icon: const Icon(Icons.more_vert, color: Colors.white70),
          onPressed: () { /* TODO: Show options (unfriend, etc) */ },
        ),
      ],
    );
  }

  // Buttons for a friend request
  Widget _buildRequestButtons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.check_circle_outline, color: AppColors.auroraGreen),
          onPressed: () { /* TODO: Accept request */ },
        ),
        IconButton(
          icon: const Icon(Icons.cancel_outlined, color: AppColors.statusRed),
          onPressed: () { /* TODO: Decline request */ },
        ),
      ],
    );
  }
}