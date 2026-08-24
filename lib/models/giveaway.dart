import 'package:flutter/material.dart';

class GiveawayItem {
  const GiveawayItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.note,
    required this.isLend,
    this.dueDateLabel,
  });

  final String id;
  final String title;
  final IconData icon;
  final String note;
  final bool isLend;
  final String? dueDateLabel;
}
