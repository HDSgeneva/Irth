import 'package:flutter/material.dart';

import '../../data/fake_dana_data.dart';
import '../../models/dana.dart';
import '../../theme/app_theme.dart';

class PointsTab extends StatelessWidget {
  const PointsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
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
                    'TOTAL DANA',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onPrimary.withValues(alpha: 0.7)),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text('$fakeCurrentPoints', style: theme.textTheme.headlineLarge?.copyWith(color: theme.colorScheme.onPrimary)),
                  Text(
                    '${fakeGhafLevels[fakeCurrentLevelIndex].name} level',
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onPrimary.withValues(alpha: 0.85)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text('Recent activity', style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final activity in fakePointsActivities)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _ActivityTile(activity: activity),
            ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});

  final PointsActivity activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: context.appColors.band, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(activity.icon, size: 20, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(activity.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    '${activity.subtitle} · ${activity.dateLabel}',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              '+${activity.points}',
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600, color: context.appColors.dana),
            ),
          ],
        ),
      ),
    );
  }
}
