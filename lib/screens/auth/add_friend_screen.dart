// lib/screens/auth/add_friend_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers.dart';
import '../../models.dart';
import '../../main.dart' show AppColors;
import '../../widgets/friend_list_item.dart';

class AddFriendScreen extends StatefulWidget {
  const AddFriendScreen({super.key});

  @override
  State<AddFriendScreen> createState() => _AddFriendScreenState();
}

class _AddFriendScreenState extends State<AddFriendScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }
  
  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      context.read<FriendsProvider>().searchAllUsers(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Friends'),
        backgroundColor: AppColors.darkPrimary,
      ),
      body: Consumer<FriendsProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _searchController,
                  autofocus: true,
                  onChanged: _onSearchChanged,
                  decoration: const InputDecoration(hintText: 'Search by name...'),
                ),
              ),
              Expanded(
                child: _buildContent(provider),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildContent(FriendsProvider provider) {
    // If the search bar has text, always show search results
    if (_searchController.text.isNotEmpty) {
      return _buildSearchResults(provider);
    }
    // Otherwise, show the list of friend requests
    else {
      return _buildFriendRequests(provider);
    }
  }

  Widget _buildSearchResults(FriendsProvider provider) {
    if (provider.isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.searchResults.isEmpty) {
      return const Center(child: Text('No users found.'));
    }
    return ListView.builder(
      itemCount: provider.searchResults.length,
      itemBuilder: (context, index) {
        final user = provider.searchResults[index];
        return ListTile(
          leading: const CircleAvatar(backgroundColor: AppColors.darkSecondary, child: Icon(Icons.person)),
          title: Text(user.displayName),
          trailing: ElevatedButton.icon(
            icon: const Icon(Icons.person_add, size: 16),
            label: const Text('Add'),
            onPressed: () { /* TODO: Send friend request */ },
          ),
        );
      },
    );
  }
  
  Widget _buildFriendRequests(FriendsProvider provider) {
    final requests = provider.friendRequests;
    if (requests.isEmpty) {
      return const Center(child: Text('No pending friend requests.'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Text(
            'Friend Requests (${requests.length})',
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white70),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final user = requests[index];
              return FriendListItem(friend: user, isRequest: true);
            },
          ),
        ),
      ],
    );
  }
}