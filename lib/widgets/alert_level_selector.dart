import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../theme/app_theme.dart';
import 'alert_level_style.dart';

class AlertLevelSelector extends StatelessWidget {
  const AlertLevelSelector({super.key, required this.selected, required this.onChanged});

  final AlertLevel selected;
  final ValueChanged<AlertLevel> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final level in AlertLevel.values)
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.xs),
            child: _AlertLevelChip(
              level: level,
              selected: level == selected,
              onTap: () => onChanged(level),
            ),
          ),
      ],
    );
  }
}

class _AlertLevelChip extends StatelessWidget {
  const _AlertLevelChip({required this.level, required this.selected, required this.onTap});

  final AlertLevel level;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = alertLevelColor(context, level);

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.buttonBorderRadius,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.14) : Colors.transparent,
          borderRadius: AppRadii.buttonBorderRadius,
          border: Border.all(color: selected ? color : theme.colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(alertLevelIcon(level), size: 15, color: selected ? color : theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              alertLevelLabel(level),
              style: theme.textTheme.labelMedium?.copyWith(
                color: selected ? color : theme.colorScheme.onSurfaceVariant,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
