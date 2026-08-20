import 'package:flutter/material.dart';

import '../../data/fake_dalla_data.dart';
import '../../theme/app_theme.dart';

enum _Budget { low, mid, high }

class FindPlaceScreen extends StatefulWidget {
  const FindPlaceScreen({super.key});

  @override
  State<FindPlaceScreen> createState() => _FindPlaceScreenState();
}

class _FindPlaceScreenState extends State<FindPlaceScreen> {
  _Budget _budget = _Budget.mid;
  bool _wheelchairAccess = true;
  bool _halal = true;
  bool _showResult = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Find a place')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Budget', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _FilterChip(
                  label: 'Under AED 100',
                  selected: _budget == _Budget.low,
                  onTap: () => setState(() {
                    _budget = _Budget.low;
                    _showResult = false;
                  }),
                ),
                _FilterChip(
                  label: 'AED 100–300',
                  selected: _budget == _Budget.mid,
                  onTap: () => setState(() {
                    _budget = _Budget.mid;
                    _showResult = false;
                  }),
                ),
                _FilterChip(
                  label: 'AED 300+',
                  selected: _budget == _Budget.high,
                  onTap: () => setState(() {
                    _budget = _Budget.high;
                    _showResult = false;
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Access & diet', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                _FilterChip(
                  label: 'Wheelchair access',
                  icon: Icons.accessible_outlined,
                  selected: _wheelchairAccess,
                  onTap: () => setState(() {
                    _wheelchairAccess = !_wheelchairAccess;
                    _showResult = false;
                  }),
                ),
                _FilterChip(
                  label: 'Halal',
                  icon: Icons.restaurant_outlined,
                  selected: _halal,
                  onTap: () => setState(() {
                    _halal = !_halal;
                    _showResult = false;
                  }),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => setState(() => _showResult = true),
                child: const Text('Find a place'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_showResult) const _PlaceCard(),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap, this.icon});

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = selected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? theme.colorScheme.primary : theme.colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 15, color: color),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                color: color,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceCard extends StatelessWidget {
  const _PlaceCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final place = fakePlaceSuggestion;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 96,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.ghaf500, AppColors.ghaf900],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              place.category.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(color: Colors.white70, letterSpacing: 1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(place.name, style: theme.textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.star_rounded, size: 16, color: context.appColors.dana),
                    const SizedBox(width: 2),
                    Text('${place.rating}', style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      place.priceLabel,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: context.appColors.band,
                    borderRadius: BorderRadius.circular(AppRadii.input),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.auto_awesome, size: 16, color: theme.colorScheme.primary),
                      const SizedBox(width: 6),
                      Expanded(child: Text(place.reason, style: theme.textTheme.bodyMedium)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
