// lib/screens/games_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../models.dart';
import '../main.dart' show AppColors;
import '../widgets.dart' show GradientButton; // We'll reuse our button

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<GameProvider>();
    final games = provider.games;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Games & Challenges'),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildFeaturedGameCard(context, games.first),
                const SizedBox(height: 24),
                Text(
                  'All Games',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ...games.skip(1).map((game) => _buildGameListItem(game)),
              ],
            ),
    );
  }

  Widget _buildFeaturedGameCard(BuildContext context, Game game) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.neonPurple, AppColors.cosmic_purple],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('FEATURED GAME', style: TextStyle(color: Colors.white70, letterSpacing: 1.5)),
          const SizedBox(height: 8),
          Text(game.title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(game.description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
          const SizedBox(height: 20),
          GradientButton(
            onPressed: () {},
            borderRadius: 12,
            gradient: const LinearGradient(colors: [AppColors.electricCyan, AppColors.auroraGreen]),
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
                Text(game.description, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.white70),
        ],
      ),
    );
  }
}