// lib/screens/friends_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/friend_list_item.dart';
import 'auth/add_friend_screen.dart'; // We will create this screen next
import '../main.dart' show AppColors;

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // We only need to watch the provider here. No builder needed for this layout.
    final provider = context.watch<FriendsProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Social'),
        backgroundColor: AppColors.darkPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_comment_outlined),
            onPressed: () {
              // TODO: Navigate to the "Create Outing" screen
            },
            tooltip: 'Create Outing',
          ),
        ],
      ),
      // The FloatingActionButton is a direct property of the Scaffold.
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
      // The body of the Scaffold is where the main content goes.
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Search Bar for existing friends
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: TextField(
                    onChanged: (value) {
                      // Use read here, as we don't need this part of the UI to rebuild.
                      context.read<FriendsProvider>().searchMyFriends(value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Search friends...',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                // "All Friends" list
                Expanded(
                  child: provider.friends.isEmpty
                      ? const Center(child: Text('No friends found.'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16.0),
                          itemCount: provider.friends.length,
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

// A reusable private widget for displaying a list of users
class _FriendsList extends StatelessWidget {
  final List<dynamic> users;
  final bool isRequestList;

  const _FriendsList({required this.users, required this.isRequestList});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: Text(
          isRequestList ? 'No pending friend requests.' : 'Your friends list is empty.',
          style: const TextStyle(color: Colors.grey, fontSize: 16),
        ),
      );
    }
    
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        // Pass the isRequest flag to the list item
        return FriendListItem(friend: user, isRequest: isRequestList);
      },
    );
  }
}