import 'package:flutter/material.dart';

import '../../data/fake_dana_data.dart';
import '../../models/dana.dart';
import '../../theme/app_theme.dart';
import '../../widgets/ghaf_tree.dart';

class TreeTab extends StatelessWidget {
  const TreeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final levels = fakeGhafLevels;
    final currentIndex = fakeCurrentLevelIndex;
    final current = levels[currentIndex];
    final isMaxLevel = currentIndex == levels.length - 1;
    final next = isMaxLevel ? null : levels[currentIndex + 1];
    final progress = isMaxLevel
        ? 1.0
        : (fakeCurrentPoints - current.threshold) / (next!.threshold - current.threshold);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Center(child: GhafTreeVisual(levelIndex: currentIndex, size: 220)),
          const SizedBox(height: AppSpacing.md),
          Center(
            child: Column(
              children: [
                Text('${current.name}  ${current.arabicName}', style: theme.textTheme.headlineMedium),
                const SizedBox(height: 4),
                Text(
                  '$fakeCurrentPoints dana',
                  style: theme.textTheme.bodyLarge?.copyWith(color: context.appColors.dana, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!isMaxLevel) ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: progress.clamp(0, 1).toDouble(),
                minHeight: 8,
                backgroundColor: context.appColors.band,
                valueColor: AlwaysStoppedAnimation(context.appColors.dana),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${fakeCurrentPoints - current.threshold} / ${next!.threshold - current.threshold} dana to ${next.name}',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ] else
            Center(
              child: Text(
                'Highest level reached',
                style: theme.textTheme.bodyMedium?.copyWith(color: context.appColors.success, fontWeight: FontWeight.w600),
              ),
            ),
          const SizedBox(height: AppSpacing.lg),
          Text('Levels', style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.sm),
          for (final (index, level) in levels.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _LevelRow(level: level, index: index, currentIndex: currentIndex),
            ),
        ],
      ),
    );
  }
}

class _LevelRow extends StatelessWidget {
  const _LevelRow({required this.level, required this.index, required this.currentIndex});

  final GhafLevelInfo level;
  final int index;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCurrent = index == currentIndex;
    final isPassed = index < currentIndex;
    final isLocked = index > currentIndex;

    return Card(
      color: isCurrent ? context.appColors.band : null,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLocked ? theme.colorScheme.outline.withValues(alpha: 0.15) : context.appColors.dana.withValues(alpha: 0.16),
              ),
              alignment: Alignment.center,
              child: Icon(
                isLocked ? Icons.lock_outline : (isPassed ? Icons.check : Icons.eco_outlined),
                size: 18,
                color: isLocked ? theme.colorScheme.onSurfaceVariant : context.appColors.dana,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${level.name}  ${level.arabicName}',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isLocked ? theme.colorScheme.onSurfaceVariant : null,
                    ),
                  ),
                  Text(
                    level.unlockDescription,
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(
              '${level.threshold}',
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
