import 'package:flutter/material.dart';

import '../models/budget.dart';

const fakeBudgetPots = [
  BudgetPot(id: 'groceries', name: 'Groceries', icon: Icons.shopping_cart_outlined, spent: 1240, total: 1800),
  BudgetPot(id: 'eating_out', name: 'Eating Out', icon: Icons.restaurant_outlined, spent: 460, total: 500),
  BudgetPot(id: 'gifts', name: 'Gifts', icon: Icons.card_giftcard_outlined, spent: 610, total: 600),
  BudgetPot(id: 'medical', name: 'Medical', icon: Icons.medical_services_outlined, spent: 180, total: 1000),
  BudgetPot(id: 'household', name: 'Household', icon: Icons.home_outlined, spent: 320, total: 700),
];

const fakeAllowances = <int, AllowanceInfo>{
  2: AllowanceInfo(remaining: 85, total: 150),
  4: AllowanceInfo(remaining: 220, total: 300),
};

const fakeMySpending = [
  SpendingEntry(id: 's1', potName: 'Eating Out', amount: 42, note: 'Coffee with Noura', dateLabel: 'Today'),
  SpendingEntry(id: 's2', potName: 'Groceries', amount: 65, note: 'Carrefour top-up', dateLabel: 'Yesterday'),
  SpendingEntry(id: 's3', potName: 'Gifts', amount: 120, note: 'Birthday gift for Ahmed', dateLabel: '3 days ago'),
];

const fakeReceiptResult = ReceiptResult(
  merchant: 'Lulu Hypermarket',
  amount: 96.50,
  suggestedPot: 'Groceries',
  lineItems: ['Milk 2L', 'Bread', 'Eggs (30pc)', 'Tomatoes 1kg'],
);

const fakeOtherSpending = <int, MemberSpendingSummary>{
  0: MemberSpendingSummary(
    totalLabel: 'AED 275 this month',
    byPot: [
      PotTotal(potName: 'Groceries', amountLabel: 'AED 150'),
      PotTotal(potName: 'Household', amountLabel: 'AED 125'),
    ],
  ),
  1: MemberSpendingSummary(
    totalLabel: 'AED 510 this month',
    byPot: [
      PotTotal(potName: 'Medical', amountLabel: 'AED 180'),
      PotTotal(potName: 'Household', amountLabel: 'AED 200'),
      PotTotal(potName: 'Groceries', amountLabel: 'AED 130'),
    ],
  ),
  3: MemberSpendingSummary(
    totalLabel: 'AED 340 this month',
    byPot: [
      PotTotal(potName: 'Eating Out', amountLabel: 'AED 220'),
      PotTotal(potName: 'Groceries', amountLabel: 'AED 120'),
    ],
  ),
  4: MemberSpendingSummary(
    totalLabel: 'AED 90 this month',
    byPot: [PotTotal(potName: 'Gifts', amountLabel: 'AED 90')],
  ),
};

const fakeSpendingRecommendations = <SpendingMode, List<SpendingRecommendation>>{
  SpendingMode.cheap: [
    SpendingRecommendation(title: 'Shawarma night', subtitle: 'Home-style, feeds everyone', priceLabel: 'AED 45'),
    SpendingRecommendation(title: 'Grocery pasta bake', subtitle: 'Pantry staples only', priceLabel: 'AED 30'),
  ],
  SpendingMode.normal: [
    SpendingRecommendation(
      title: 'Al Fanar family table',
      subtitle: "Their usual Friday order",
      priceLabel: 'AED 180',
    ),
    SpendingRecommendation(title: 'Home BBQ', subtitle: 'Butcher run plus sides', priceLabel: 'AED 140'),
  ],
  SpendingMode.fancy: [
    SpendingRecommendation(title: 'Amwaj by the sea', subtitle: 'Special occasion dinner', priceLabel: 'AED 620'),
    SpendingRecommendation(title: 'Private chef at home', subtitle: 'Full family, no cooking', priceLabel: 'AED 900'),
  ],
};
