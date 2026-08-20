import 'package:flutter/material.dart';

import '../../data/fake_care_data.dart';
import '../../models/care_reminder.dart';
import '../../theme/app_theme.dart';

class CareTab extends StatelessWidget {
  const CareTab({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.groups_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Expanded(
              child: Text(
                'Every task has a backup, so nothing depends on one person remembering.',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        for (final reminder in fakeCareReminders)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.sm),
            child: _CareReminderCard(reminder: reminder),
          ),
      ],
    );
  }
}

class _CareReminderCard extends StatelessWidget {
  const _CareReminderCard({required this.reminder});

  final CareReminder reminder;

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
                  child: Icon(reminder.icon, color: theme.colorScheme.primary, size: 20),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(reminder.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      Text(
                        reminder.scheduleLabel,
                        style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                Expanded(
                  child: _ResponsibleTile(
                    label: 'Primary',
                    name: reminder.primaryName,
                    avatarIndex: reminder.primaryAvatarIndex,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: _ResponsibleTile(
                    label: 'Backup',
                    name: reminder.backupName,
                    avatarIndex: reminder.backupAvatarIndex,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ResponsibleTile extends StatelessWidget {
  const _ResponsibleTile({required this.label, required this.name, required this.avatarIndex});

  final String label;
  final String name;
  final int avatarIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        CircleAvatar(
          radius: 14,
          backgroundColor: AppAvatarColors.forIndex(avatarIndex),
          child: Text(name[0], style: const TextStyle(color: Colors.white, fontSize: 11)),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              Text(
                name,
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
