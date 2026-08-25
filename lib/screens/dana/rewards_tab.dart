import 'package:flutter/material.dart';

import '../../data/fake_dana_data.dart';
import '../../models/dana.dart';
import '../../theme/app_theme.dart';

class RewardsTab extends StatefulWidget {
  const RewardsTab({super.key});

  @override
  State<RewardsTab> createState() => _RewardsTabState();
}

class _RewardsTabState extends State<RewardsTab> {
  final Set<String> _redeemedIds = {};

  @override
  Widget build(BuildContext context) {
    final currentIndex = fakeCurrentLevelIndex;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          for (final (levelIndex, level) in fakeGhafLevels.indexed) ...[
            _LevelSectionHeader(level: level, levelIndex: levelIndex, currentIndex: currentIndex),
            const SizedBox(height: AppSpacing.sm),
            for (final reward in fakeRewards.where((r) => r.levelIndex == levelIndex))
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _RewardCard(
                  reward: reward,
                  unlocked: levelIndex <= currentIndex,
                  unlockLevelName: level.name,
                  redeemed: _redeemedIds.contains(reward.id),
                  onRedeem: () => setState(() => _redeemedIds.add(reward.id)),
                ),
              ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _LevelSectionHeader extends StatelessWidget {
  const _LevelSectionHeader({required this.level, required this.levelIndex, required this.currentIndex});

  final GhafLevelInfo level;
  final int levelIndex;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCurrent = levelIndex == currentIndex;
    return Row(
      children: [
        Expanded(child: Text('${level.name}  ${level.arabicName}', style: theme.textTheme.headlineSmall)),
        if (isCurrent)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: context.appColors.dana.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Your level',
              style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.dana, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}

class _RewardCard extends StatelessWidget {
  const _RewardCard({
    required this.reward,
    required this.unlocked,
    required this.unlockLevelName,
    required this.redeemed,
    required this.onRedeem,
  });

  final Reward reward;
  final bool unlocked;
  final String unlockLevelName;
  final bool redeemed;
  final VoidCallback onRedeem;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isVoucher = reward.kind == RewardKind.voucher;

    final card = Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(color: context.appColors.band, shape: BoxShape.circle),
              alignment: Alignment.center,
              child: Icon(reward.icon, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(reward.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Text(reward.subtitle, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  if (unlocked) ...[
                    const SizedBox(height: AppSpacing.sm),
                    if (isVoucher)
                      redeemed
                          ? Row(
                              children: [
                                Icon(Icons.check_circle, size: 16, color: context.appColors.success),
                                const SizedBox(width: 4),
                                Text(
                                  'Redeemed, check your email',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: context.appColors.success,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            )
                          : OutlinedButton(onPressed: onRedeem, child: const Text('Redeem'))
                    else
                      Row(
                        children: [
                          Icon(Icons.check_circle, size: 16, color: context.appColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'Unlocked',
                            style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.success, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );

    if (unlocked) return card;

    return Stack(
      children: [
        Opacity(opacity: 0.35, child: card),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: AppRadii.cardBorderRadius,
              border: Border.all(color: theme.colorScheme.outline),
            ),
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: theme.colorScheme.outline),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock_outline, size: 14, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text('Unlocks at $unlockLevelName', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
