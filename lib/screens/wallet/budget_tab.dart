import 'package:flutter/material.dart';

import '../../data/fake_budget_data.dart';
import '../../data/fake_chat_data.dart';
import '../../models/budget.dart';
import '../../theme/app_theme.dart';
import 'log_spending_screen.dart';
import 'member_spending_screen.dart';
import 'my_spending_screen.dart';

class BudgetTab extends StatefulWidget {
  const BudgetTab({super.key});

  @override
  State<BudgetTab> createState() => _BudgetTabState();
}

class _BudgetTabState extends State<BudgetTab> {
  SpendingMode _mode = SpendingMode.normal;
  final List<SpendingEntry> _myEntries = List.of(fakeMySpending);

  Future<void> _openLogSpending() async {
    final entry = await Navigator.of(context).push<SpendingEntry>(
      MaterialPageRoute(builder: (_) => const LogSpendingScreen()),
    );
    if (entry != null) {
      setState(() => _myEntries.insert(0, entry));
    }
  }

  void _openMember(int index) {
    if (index == currentMemberIndex) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MySpendingScreen(entries: _myEntries)),
      );
    } else {
      final member = fakeFamilyMembers[index];
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => MemberSpendingScreen(memberName: member.name, memberIndex: index)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openLogSpending,
        icon: const Icon(Icons.add),
        label: const Text('Log spending'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Spending mode', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _SpendingModeToggle(selected: _mode, onChanged: (mode) => setState(() => _mode = mode)),
            const SizedBox(height: AppSpacing.sm),
            for (final rec in fakeSpendingRecommendations[_mode]!)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: _RecommendationTile(recommendation: rec),
              ),
            const SizedBox(height: AppSpacing.lg),
            Text('Budget pots', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            for (final pot in fakeBudgetPots)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _PotCard(pot: pot),
              ),
            const SizedBox(height: AppSpacing.md),
            Text('Personal allowances', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            for (final (index, member) in fakeFamilyMembers.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _AllowanceRow(name: member.name, avatarIndex: member.avatarIndex, allowance: fakeAllowances[index]),
              ),
            const SizedBox(height: AppSpacing.md),
            Text('Spending', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Tap yourself to see your own purchases. Tap anyone else and you only see a total.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 76,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final (index, member) in fakeFamilyMembers.indexed)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.md),
                      child: _MemberAvatar(
                        name: member.name,
                        avatarIndex: member.avatarIndex,
                        isMe: index == currentMemberIndex,
                        onTap: () => _openMember(index),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class _SpendingModeToggle extends StatelessWidget {
  const _SpendingModeToggle({required this.selected, required this.onChanged});

  final SpendingMode selected;
  final ValueChanged<SpendingMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SpendingMode>(
      segments: const [
        ButtonSegment(value: SpendingMode.cheap, label: Text('Cheap')),
        ButtonSegment(value: SpendingMode.normal, label: Text('Normal')),
        ButtonSegment(value: SpendingMode.fancy, label: Text('Fancy')),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (chosen) => onChanged(chosen.first),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({required this.recommendation});

  final SpendingRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(recommendation.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    recommendation.subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            Text(recommendation.priceLabel, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _PotCard extends StatelessWidget {
  const _PotCard({required this.pot});

  final BudgetPot pot;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final barColor = pot.isOverBudget ? colors.nida : (pot.ratio >= 0.85 ? colors.amber : theme.colorScheme.primary);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(pot.icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(pot.name, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                ),
                Text(
                  'AED ${pot.spent.toStringAsFixed(0)} / ${pot.total.toStringAsFixed(0)}',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(99),
              child: LinearProgressIndicator(
                value: pot.ratio.clamp(0, 1).toDouble(),
                minHeight: 6,
                backgroundColor: colors.band,
                valueColor: AlwaysStoppedAnimation(barColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllowanceRow extends StatelessWidget {
  const _AllowanceRow({required this.name, required this.avatarIndex, required this.allowance});

  final String name;
  final int avatarIndex;
  final AllowanceInfo? allowance;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: allowance == null ? context.appColors.band : null,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.cardPadding),
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundColor: AppAvatarColors.forIndex(avatarIndex),
              child: Text(name[0], style: const TextStyle(color: Colors.white, fontSize: 12)),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(child: Text(name, style: theme.textTheme.bodyLarge)),
            if (allowance != null)
              Text(
                'AED ${allowance!.remaining.toStringAsFixed(0)} / ${allowance!.total.toStringAsFixed(0)}',
                style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
              )
            else
              Text(
                'No personal allowance',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
          ],
        ),
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.name, required this.avatarIndex, required this.isMe, required this.onTap});

  final String name;
  final int avatarIndex;
  final bool isMe;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppAvatarColors.forIndex(avatarIndex),
              child: Text(name[0], style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 4),
            Text(
              isMe ? 'Me' : name.split(' ').first,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
