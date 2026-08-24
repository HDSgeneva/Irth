import 'package:flutter/material.dart';

import '../../data/fake_budget_data.dart';
import '../../theme/app_theme.dart';

class MemberSpendingScreen extends StatelessWidget {
  const MemberSpendingScreen({super.key, required this.memberName, required this.memberIndex});

  final String memberName;
  final int memberIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final summary = fakeOtherSpending[memberIndex];

    return Scaffold(
      appBar: AppBar(title: Text("$memberName's spending")),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Row(
              children: [
                Icon(Icons.lock_outline, size: 14, color: theme.colorScheme.onSurfaceVariant),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    'You only see totals here, never individual purchases.',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            if (summary == null)
              Text('No spending recorded yet.', style: theme.textTheme.bodyMedium)
            else ...[
              Card(
                color: theme.colorScheme.primary,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL SPENT',
                        style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onPrimary.withValues(alpha: 0.7)),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(summary.totalLabel, style: theme.textTheme.headlineMedium?.copyWith(color: theme.colorScheme.onPrimary)),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('By pot', style: theme.textTheme.headlineSmall),
              const SizedBox(height: AppSpacing.sm),
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                  child: Column(
                    children: [
                      for (final pot in summary.byPot)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                          child: Row(
                            children: [
                              Expanded(child: Text(pot.potName, style: theme.textTheme.bodyLarge)),
                              Text(pot.amountLabel, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
