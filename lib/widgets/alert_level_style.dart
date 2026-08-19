import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../theme/app_theme.dart';

Color alertLevelColor(BuildContext context, AlertLevel level) {
  final colors = context.appColors;
  final onSurfaceVariant = Theme.of(context).colorScheme.onSurfaceVariant;
  return switch (level) {
    AlertLevel.silent => onSurfaceVariant,
    AlertLevel.normal => colors.khor,
    AlertLevel.urgent => colors.amber,
    AlertLevel.critical => colors.nida,
  };
}

String alertLevelLabel(AlertLevel level) {
  return switch (level) {
    AlertLevel.silent => 'Silent',
    AlertLevel.normal => 'Normal',
    AlertLevel.urgent => 'Urgent',
    AlertLevel.critical => 'Critical',
  };
}

IconData alertLevelIcon(AlertLevel level) {
  return switch (level) {
    AlertLevel.silent => Icons.notifications_off_outlined,
    AlertLevel.normal => Icons.notifications_outlined,
    AlertLevel.urgent => Icons.priority_high_rounded,
    AlertLevel.critical => Icons.emergency_outlined,
  };
}
