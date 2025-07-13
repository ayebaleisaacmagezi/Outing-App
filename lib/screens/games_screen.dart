// lib/screens/games_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../models.dart';
import '../main.dart' show AppColors, AppGradients;
import '../widgets/gradient_button.dart'; // <-- CORRECT IMPORT

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Games & Challenges'),
        centerTitle: true,
        backgroundColor: AppColors.darkPrimary,
      ),
      body: provider.isLoading || provider.games.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildFeaturedGameCard(context, provider.games.first),
                const SizedBox(height: 24),
                Text(
                  'All Games',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ...provider.games.skip(1).map((game) => _buildGameListItem(game)),
              ],
            ),
    );
  }

  Widget _buildFeaturedGameCard(BuildContext context, Game game) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.neonPurple, AppColors.cosmicPurple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('FEATURED GAME', style: TextStyle(color: Colors.white.withOpacity(0.8), letterSpacing: 1.5, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(game.title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 8),
          Text(game.description, style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8), height: 1.4)),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () {},
            borderRadius: 12,
            gradient: AppGradients.aurora, // Using predefined gradient
            child: const Text('Play Now', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildGameListItem(Game game) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.darkSecondary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(game.icon, color: AppColors.electricCyan, size: 28),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(game.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(game.description, style: TextStyle(color: Colors.grey[400])),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[600]),
        ],
      ),
    );
  }
}