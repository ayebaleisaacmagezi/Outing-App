// lib/screens/friends_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/friend_list_item.dart';
import '../widgets/glow_button.dart';
import 'auth/add_friend_screen.dart';
import '../main.dart' show AppColors, AppGradients;

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FriendsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
        backgroundColor: AppColors.darkPrimary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const AddFriendScreen(),
          ));
        },
        backgroundColor: AppColors.electricCyan,
        tooltip: 'Add Friends',
        child: const Icon(Icons.person_add, color: AppColors.darkPrimary),
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: TextField(
                    onChanged: (value) {
                      context.read<FriendsProvider>().searchMyFriends(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search friends...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),

                // CORRECTED "CREATE OUTING" BUTTON
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft, // Aligns the content to the left
                    child: GlowButton(
                      onPressed: () {
                        // TODO: Navigate to the Create Outing flow
                      },
                      gradient: AppGradients.aurora,
                      // The child's size will determine the button's overall width
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0), // Reduced horizontal padding
                        child: Row(
                          mainAxisSize: MainAxisSize.min, // Make the Row take minimum space
                          children: const [
                            Icon(Icons.add, size: 18), // Slightly smaller icon
                            SizedBox(width: 6), // Slightly smaller gap
                            Text(
                              'Create a Plan',
                              style: TextStyle(fontSize: 14), // Smaller font size
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: provider.friends.isEmpty
                      ? const Center(child: Text('No friends found.'))
                      : ListView.separated(
                          padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                          itemCount: provider.friends.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            final friend = provider.friends[index];
                            return FriendListItem(friend: friend, isRequest: false);
                          },
                        ),
                ),
              ],
            ),
    );
  }
}