import 'package:flutter/material.dart';

class GhafLevelInfo {
  const GhafLevelInfo({
    required this.name,
    required this.arabicName,
    required this.threshold,
    required this.unlockDescription,
  });

  final String name;
  final String arabicName;
  final int threshold;
  final String unlockDescription;
}

class PointsActivity {
  const PointsActivity({
    required this.title,
    required this.subtitle,
    required this.points,
    required this.icon,
    required this.dateLabel,
  });

  final String title;
  final String subtitle;
  final int points;
  final IconData icon;
  final String dateLabel;
}

enum RewardKind { appReward, voucher }

class Reward {
  const Reward({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.levelIndex,
    required this.kind,
  });

  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final int levelIndex;
  final RewardKind kind;
}

int levelIndexForPoints(int points, List<GhafLevelInfo> levels) {
  var index = 0;
  for (var i = 0; i < levels.length; i++) {
    if (points >= levels[i].threshold) index = i;
  }
  return index;
}
