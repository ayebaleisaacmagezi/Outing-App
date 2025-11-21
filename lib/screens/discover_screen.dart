// lib/screens/discover_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../widgets/venue_card.dart';
import '../widgets/filters_bottom_sheet.dart';
import '../widgets/glow_button.dart';
import '../main.dart' show AppColors, AppGradients;

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _OutingAppBar(),
          const _SearchSection(),
          _CategoriesRow(
            categories: provider.primaryCategories,
            activeCategory: provider.activeCategory,
            onCategorySelected: (category) => provider.selectCategory(category),
          ),
          const _ActionButtons(),
          const _NearYouHeader(),
          _buildVenueList(provider),
        ],
      ),
    );
  }

  Widget _buildVenueList(DiscoverProvider provider) {
    if (provider.isLoading) {
      return const SliverFillRemaining(
        child: Center(child: CircularProgressIndicator()),
      );
    }
    
    if (provider.venues.isEmpty && !provider.isLoading) {
       return const SliverFillRemaining(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              "No venues found for the selected category.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final venue = provider.venues[index];
            return VenueCard(
              venue: venue,
              currentPosition: provider.currentPosition,
            );
          },
          childCount: provider.venues.length,
        ),
      ),
    );
  }
}

// Private sub-widgets for discover_screen.dart
class _OutingAppBar extends StatelessWidget {
  const _OutingAppBar();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      pinned: true,
      backgroundColor: AppColors.darkPrimary.withOpacity(0.95),
      title: ShaderMask(
        shaderCallback: (bounds) => AppGradients.aurora.createShader(bounds),
        child: const Text('OutingApp',
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.darkSecondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.sunsetOrange.withOpacity(0.3)),
            ),
            child: const Row(
              children: [
                _PulseDot(),
                SizedBox(width: 8),
                Text("Streak: 12",
                    style: TextStyle(
                        color: AppColors.sunsetOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 14)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();
  @override
  Widget build(BuildContext context) {
    final currentAddress = context.watch<DiscoverProvider>().currentAddress;
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                hintText: 'Search places, friends, activities...',
                prefixIcon:
                    Icon(Icons.search, color: AppColors.electricCyan),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        color: AppColors.electricCyan, size: 16),
                    const SizedBox(width: 8),
                    Text(currentAddress,
                        style: TextStyle(color: Colors.grey[300])),
                  ],
                ),
                TextButton.icon(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) => const FiltersBottomSheet(),
                    );
                  },
                  icon: const Icon(Icons.filter_list, size: 16),
                  label: const Text('Filters'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.electricCyan,
                    backgroundColor: AppColors.darkSecondary.withOpacity(0.5),
                    side:
                        BorderSide(color: AppColors.electricCyan.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoriesRow extends StatelessWidget {
  final List<String> categories;
  final String activeCategory;
  final Function(String) onCategorySelected;

  const _CategoriesRow({
    required this.categories,
    required this.activeCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            final bool isActive = category == activeCategory;
            
            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              // Use ElevatedButton as the base for consistent sizing
              child: ElevatedButton(
                onPressed: () => onCategorySelected(category),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding to allow Ink to fill
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  // Add the border for the inactive state, remove for active
                  side: isActive
                      ? BorderSide.none
                      : BorderSide(color: AppColors.electricCyan.withOpacity(0.3)),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    // Apply gradient ONLY if active
                    gradient: isActive ? AppGradients.aurora : null,
                    // If not active, the background is handled by the button's transparent color
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // Change text color based on state
                        color: isActive ? AppColors.darkPrimary : AppColors.electricCyan,
                      ),
                    ),
                  ),
                ),
              ),  
            );
          },
        ),
      ),
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(
          children: [
            Expanded(
              child: GlowButton(
                onPressed: () {},
                gradient: AppGradients.aurora,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, size: 20),
                    SizedBox(width: 8),
                    Text('Create Outing'),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chat_bubble_outline, size: 20),
                    SizedBox(width: 8),
                    Text('Group Chat'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NearYouHeader extends StatelessWidget {
  const _NearYouHeader();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 8.0),
        child: Text(
          'Near You',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();
  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot> with SingleTickerProviderStateMixin {
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