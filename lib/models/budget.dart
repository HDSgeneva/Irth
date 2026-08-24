import 'package:flutter/material.dart';

enum SpendingMode { cheap, normal, fancy }

class BudgetPot {
  const BudgetPot({
    required this.id,
    required this.name,
    required this.icon,
    required this.spent,
    required this.total,
  });

  final String id;
  final String name;
  final IconData icon;
  final double spent;
  final double total;

  double get ratio => total == 0 ? 0 : spent / total;
  bool get isOverBudget => spent > total;
}

class AllowanceInfo {
  const AllowanceInfo({required this.remaining, required this.total});

  final double remaining;
  final double total;
}

class SpendingEntry {
  const SpendingEntry({
    required this.id,
    required this.potName,
    required this.amount,
    required this.note,
    required this.dateLabel,
    this.fromReceipt = false,
  });

  final String id;
  final String potName;
  final double amount;
  final String note;
  final String dateLabel;
  final bool fromReceipt;
}

class ReceiptResult {
  const ReceiptResult({
    required this.merchant,
    required this.amount,
    required this.suggestedPot,
    required this.lineItems,
  });

  final String merchant;
  final double amount;
  final String suggestedPot;
  final List<String> lineItems;
}

class SpendingRecommendation {
  const SpendingRecommendation({
    required this.title,
    required this.subtitle,
    required this.priceLabel,
  });

  final String title;
  final String subtitle;
  final String priceLabel;
}

class PotTotal {
  const PotTotal({required this.potName, required this.amountLabel});

  final String potName;
  final String amountLabel;
}

class MemberSpendingSummary {
  const MemberSpendingSummary({required this.totalLabel, required this.byPot});

  final String totalLabel;
  final List<PotTotal> byPot;
}
