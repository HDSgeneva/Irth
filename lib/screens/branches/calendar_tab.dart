import 'package:flutter/material.dart';

import '../../data/fake_calendar_data.dart';
import '../../models/calendar_event.dart';
import '../../theme/app_theme.dart';

class CalendarTab extends StatelessWidget {
  const CalendarTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    String? currentDay;
    final children = <Widget>[];

    for (final event in fakeCalendarEvents) {
      if (event.dayLabel != currentDay) {
        currentDay = event.dayLabel;
        if (children.isNotEmpty) children.add(const SizedBox(height: AppSpacing.sm));
        children.add(
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Text(
              currentDay.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                letterSpacing: 1.0,
              ),
            ),
          ),
        );
      }
      children.add(
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.sm),
          child: _CalendarEventTile(event: event),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.visibility_off_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                "Everyone sees when you're busy. Only shared events show what it's for.",
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        ...children,
      ],
    );
  }
}

class _CalendarEventTile extends StatelessWidget {
  const _CalendarEventTile({required this.event});

  final CalendarEvent event;

  void _openDetail(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheetTop)),
      ),
      builder: (_) => _EventDetailSheet(event: event),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarColor = AppAvatarColors.forIndex(event.ownerAvatarIndex);
    final displayTitle = event.isShared ? event.title : 'Busy';

    return Card(
      child: InkWell(
        borderRadius: AppRadii.cardBorderRadius,
        onTap: () => _openDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.cardPadding),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 34,
                decoration: BoxDecoration(color: avatarColor, borderRadius: BorderRadius.circular(2)),
              ),
              const SizedBox(width: AppSpacing.sm),
              CircleAvatar(
                radius: 16,
                backgroundColor: avatarColor,
                child: Text(event.ownerName[0], style: const TextStyle(color: Colors.white, fontSize: 12)),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayTitle,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: event.isShared ? null : theme.colorScheme.onSurfaceVariant,
                        fontStyle: event.isShared ? FontStyle.normal : FontStyle.italic,
                      ),
                    ),
                    Text(
                      event.isShared ? '${event.timeLabel} · ${event.ownerName}' : event.timeLabel,
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              if (!event.isShared)
                Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.onSurfaceVariant),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDetailSheet extends StatelessWidget {
  const _EventDetailSheet({required this.event});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarColor = AppAvatarColors.forIndex(event.ownerAvatarIndex);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: avatarColor,
                  child: Text(event.ownerName[0], style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: AppSpacing.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(event.ownerName, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                    Text(
                      '${event.dayLabel} · ${event.timeLabel}',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            if (event.isShared) ...[
              Text(event.title, style: theme.textTheme.headlineSmall),
              if (event.location != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    Icon(Icons.place_outlined, size: 16, color: theme.colorScheme.onSurfaceVariant),
                    const SizedBox(width: 4),
                    Text(
                      event.location!,
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              Row(
                children: [
                  Icon(Icons.groups_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Text(
                    'Shared with the family',
                    style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            ] else ...[
              Row(
                children: [
                  Icon(Icons.lock_outline, size: 18, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 6),
                  Text('Busy', style: theme.textTheme.headlineSmall),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                "${event.ownerName} hasn't shared what this is for. You only see that the time is taken.",
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
