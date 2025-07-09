// lib/screens/discover_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets.dart';
import '../main.dart' show AppColors;

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.darkPrimary.withAlpha(230), // CORRECTED
            title: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [AppColors.neonPurple, AppColors.electricCyan],
              ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
              child: const Text('OutingApp'),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.darkSecondary,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.sunsetOrange.withAlpha(77)), // CORRECTED
                  ),
                  child: const Row(
                    children: [
                      PulseDot(),
                      SizedBox(width: 8),
                      Text("Streak: 12", style: TextStyle(color: AppColors.sunsetOrange, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: 'Search places, friends, activities...',
                      prefixIcon: Icon(Icons.search, color: AppColors.electricCyan),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.location_on, color: AppColors.electricCyan, size: 16),
                          SizedBox(width: 4),
                          Text("Downtown Area", style: TextStyle(color: Colors.white70)),
                        ],
                      ),
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.filter_list, size: 16),
                        label: const Text('Filters'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.electricCyan,
                          side: BorderSide(color: AppColors.electricCyan.withAlpha(77)), // CORRECTED
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                itemCount: provider.categories.length,
                itemBuilder: (context, index) {
                  final category = provider.categories[index];
                  final bool isActive = category == provider.activeCategory;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: isActive
                      ? GradientButton(
                          onPressed: () {},
                          borderRadius: 20,
                          child: Text(
                            category,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: () => provider.selectCategory(category),
                          style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.grey[300],
                              side: BorderSide(color: AppColors.electricCyan.withAlpha(77)), // CORRECTED
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                          ),
                          child: Text(category),
                        ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: Row(
                children: [
                  Expanded(
                    child: GradientButton(
                      onPressed: () {},
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, size: 20),
                          SizedBox(width: 8),
                          Text('Create Outing', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline, size: 20),
                      label: const Text('Group Chat'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14)
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Near You',
                style: TextStyle(color: AppColors.electricCyan, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          provider.isLoading
            ? const SliverToBoxAdapter(child: Center(child: Padding(padding: EdgeInsets.all(32.0), child: CircularProgressIndicator())))
            : SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final venue = provider.venues[index];
                      return VenueCard(venue: venue, currentPosition: provider.currentPosition, );
                    },
                    childCount: provider.venues.length,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}

class PulseDot extends StatefulWidget {
  const PulseDot({super.key});
  @override
  State<PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<PulseDot> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _controller,
      child: Container(
        width: 8,
        height: 8,
        decoration: const BoxDecoration(
          color: AppColors.sunsetOrange,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}