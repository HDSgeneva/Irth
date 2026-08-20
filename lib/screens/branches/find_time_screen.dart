import 'package:flutter/material.dart';

import '../../data/fake_chat_data.dart';
import '../../data/fake_dalla_data.dart';
import '../../theme/app_theme.dart';

class FindTimeScreen extends StatefulWidget {
  const FindTimeScreen({super.key});

  @override
  State<FindTimeScreen> createState() => _FindTimeScreenState();
}

class _FindTimeScreenState extends State<FindTimeScreen> {
  final Set<int> _selected = {0, 1, 3};
  bool _showResult = false;

  void _toggle(int index) {
    setState(() {
      if (_selected.contains(index)) {
        _selected.remove(index);
      } else {
        _selected.add(index);
      }
      _showResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Find a time')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Who needs to meet?', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final (index, member) in fakeFamilyMembers.indexed)
                  _MemberChip(
                    name: member.name,
                    avatarIndex: member.avatarIndex,
                    selected: _selected.contains(index),
                    onTap: () => _toggle(index),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _selected.length >= 2 ? () => setState(() => _showResult = true) : null,
                child: const Text('Find a time'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_showResult) const _SuggestionCard(),
          ],
        ),
      ),
    );
  }
}

class _MemberChip extends StatelessWidget {
  const _MemberChip({
    required this.name,
    required this.avatarIndex,
    required this.selected,
    required this.onTap,
  });

  final String name;
  final int avatarIndex;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = AppAvatarColors.forIndex(avatarIndex);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.only(left: 6, right: 14, top: 6, bottom: 6),
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: selected ? theme.colorScheme.primary : theme.colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: color,
              child: Text(name[0], style: const TextStyle(color: Colors.white, fontSize: 10)),
            ),
            const SizedBox(width: 6),
            Text(
              name,
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final onPrimary = theme.colorScheme.onPrimary;

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SUGGESTED SLOT',
              style: theme.textTheme.labelMedium?.copyWith(color: onPrimary.withValues(alpha: 0.7)),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${fakeTimeSuggestion.dayLabel} · ${fakeTimeSuggestion.timeRangeLabel}',
              style: theme.textTheme.headlineMedium?.copyWith(color: onPrimary),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              fakeTimeSuggestion.reason,
              style: theme.textTheme.bodyMedium?.copyWith(color: onPrimary.withValues(alpha: 0.9)),
            ),
          ],
        ),
      ),
    );
  }
}
