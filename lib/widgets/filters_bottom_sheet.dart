// lib/widgets/filters_bottom_sheet.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers.dart';
import '../main.dart' show AppColors;

class FiltersBottomSheet extends StatelessWidget {
  const FiltersBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DiscoverProvider>(
      builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            color: AppColors.darkSecondary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('More Filters', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: () => provider.clearSecondaryFilters(),
                    child: const Text('Reset', style: TextStyle(color: AppColors.electricCyan)),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // BUDGET FILTER (Multi-select)
              _buildMultiSelectFilterSection(
                title: 'Budget',
                options: provider.allBudgets,
                selectedOptions: provider.selectedBudgets,
                onSelected: (budget) => provider.toggleBudget(budget),
              ),
              const SizedBox(height: 24),

              // SORT BY POPULARITY
              _buildSortSection(provider),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Show Results'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMultiSelectFilterSection({
    required String title,
    required List<String> options,
    required List<String> selectedOptions,
    required ValueChanged<String> onSelected,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12.0,
          runSpacing: 10.0,
          children: options.map((option) {
            final isSelected = selectedOptions.contains(option);
            return FilterChip(
              label: Text(option),
              selected: isSelected,
              onSelected: (selected) {
                onSelected(option);
              },
              backgroundColor: AppColors.darkPrimary,
              selectedColor: AppColors.electricCyan,
              labelStyle: TextStyle(color: isSelected ? AppColors.darkPrimary : Colors.white70),
              shape: StadiumBorder(),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSortSection(DiscoverProvider provider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Sort by Popularity', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        Switch(
          value: provider.sortByPopularity,
          onChanged: (value) => provider.toggleSortByPopularity(),
          activeColor: AppColors.electricCyan,
        ),
      ],
    );
  }
}