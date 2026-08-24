import 'package:flutter/material.dart';

import '../../data/fake_calendar_data.dart';
import '../../data/fake_giveaway_data.dart';
import '../../models/giveaway.dart';
import '../../theme/app_theme.dart';

enum _GiveLendMode { give, lend }

class GiveLendTab extends StatefulWidget {
  const GiveLendTab({super.key});

  @override
  State<GiveLendTab> createState() => _GiveLendTabState();
}

class _GiveLendTabState extends State<GiveLendTab> {
  _GiveLendMode _mode = _GiveLendMode.give;
  final Set<String> _claimedIds = {};

  @override
  Widget build(BuildContext context) {
    final items = _mode == _GiveLendMode.give ? fakeGiveawayItems : fakeLendItems;

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        SegmentedButton<_GiveLendMode>(
          segments: const [
            ButtonSegment(value: _GiveLendMode.give, label: Text('Give away'), icon: Icon(Icons.volunteer_activism_outlined)),
            ButtonSegment(value: _GiveLendMode.lend, label: Text('Lend'), icon: Icon(Icons.handshake_outlined)),
          ],
          selected: {_mode},
          showSelectedIcon: false,
          onSelectionChanged: (chosen) => setState(() => _mode = chosen.first),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _GiveawayItemCard(
              item: item,
              claimed: _claimedIds.contains(item.id),
              onClaim: () => setState(() => _claimedIds.add(item.id)),
            ),
          ),
      ],
    );
  }
}

class _GiveawayItemCard extends StatelessWidget {
  const _GiveawayItemCard({required this.item, required this.claimed, required this.onClaim});

  final GiveawayItem item;
  final bool claimed;
  final VoidCallback onClaim;

  void _showPickupSheet(BuildContext context) {
    final dinner = fakeCalendarEvents.firstWhere((e) => e.id == 'e5');
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheetTop)),
      ),
      builder: (sheetContext) {
        final theme = Theme.of(sheetContext);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xl),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Pick up at the next family dinner', style: theme.textTheme.headlineSmall),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Icon(Icons.event_outlined, color: theme.colorScheme.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(dinner.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                          Text(
                            '${dinner.dayLabel} · ${dinner.timeLabel}${dinner.location != null ? ' · ${dinner.location}' : ''}',
                            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: context.appColors.band, shape: BoxShape.circle),
                  alignment: Alignment.center,
                  child: Icon(item.icon, color: theme.colorScheme.primary, size: 20),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      Text(item.note, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            if (!claimed)
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: onClaim, child: Text(item.isLend ? 'Borrow it' : 'Claim it')),
              )
            else ...[
              Row(
                children: [
                  Icon(Icons.check_circle, size: 16, color: context.appColors.success),
                  const SizedBox(width: 4),
                  Text(
                    item.isLend ? 'Borrowed by you' : 'Claimed by you',
                    style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.success, fontWeight: FontWeight.w600),
                  ),
                  if (item.isLend && item.dueDateLabel != null) ...[
                    const SizedBox(width: AppSpacing.xs),
                    Text('· ${item.dueDateLabel}', style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.amber, fontWeight: FontWeight.w600)),
                  ],
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () => _showPickupSheet(context),
                  icon: const Icon(Icons.restaurant_outlined, size: 18),
                  label: const Text('Pick up at next family dinner'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
