import 'package:flutter/material.dart';

class CareReminder {
  const CareReminder({
    required this.id,
    required this.title,
    required this.icon,
    required this.scheduleLabel,
    required this.primaryName,
    required this.primaryAvatarIndex,
    required this.backupName,
    required this.backupAvatarIndex,
  });

  final String id;
  final String title;
  final IconData icon;
  final String scheduleLabel;
  final String primaryName;
  final int primaryAvatarIndex;
  final String backupName;
  final int backupAvatarIndex;
}
