import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'find_place_screen.dart';
import 'find_time_screen.dart';
import 'plan_trip_screen.dart';

class PlanTab extends StatelessWidget {
  const PlanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Card(
          color: theme.colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'دلة  Dalla',
                  style: theme.textTheme.headlineSmall?.copyWith(color: theme.colorScheme.onPrimary),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  "Your family's planner. Tell it what you need and it does the coordinating.",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onPrimary.withValues(alpha: 0.85),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _DallaActionCard(
          icon: Icons.schedule_outlined,
          title: 'Find a time',
          subtitle: 'Pick who needs to meet and get a slot everyone can make.',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FindTimeScreen()),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _DallaActionCard(
          icon: Icons.place_outlined,
          title: 'Find a place',
          subtitle: 'Set a few filters and get one place that fits everyone.',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const FindPlaceScreen()),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        _DallaActionCard(
          icon: Icons.flight_takeoff_outlined,
          title: 'Plan a trip',
          subtitle: 'A full itinerary — flights, stay, and who needs to take leave.',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const PlanTripScreen()),
          ),
        ),
      ],
    );
  }
}

class _DallaActionCard extends StatelessWidget {
  const _DallaActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: AppRadii.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: context.appColors.band, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}
