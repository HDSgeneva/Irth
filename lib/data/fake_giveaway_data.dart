import 'package:flutter/material.dart';

import '../models/giveaway.dart';

const fakeGiveawayItems = [
  GiveawayItem(
    id: 'g1',
    title: 'Baby clothes, 0–6 months',
    icon: Icons.checkroom_outlined,
    note: 'Barely worn, mixed sizes',
    isLend: false,
  ),
  GiveawayItem(
    id: 'g2',
    title: 'Dining table, seats 6',
    icon: Icons.table_restaurant_outlined,
    note: 'Light scratches, still solid',
    isLend: false,
  ),
  GiveawayItem(
    id: 'g3',
    title: "Box of children's books",
    icon: Icons.menu_book_outlined,
    note: 'Arabic and English',
    isLend: false,
  ),
];

const fakeLendItems = [
  GiveawayItem(
    id: 'l1',
    title: 'Extendable ladder',
    icon: Icons.construction_outlined,
    note: '3 metres, aluminium',
    isLend: true,
    dueDateLabel: 'Return by 6 Sep',
  ),
  GiveawayItem(
    id: 'l2',
    title: 'Camping tent, 4-person',
    icon: Icons.cabin_outlined,
    note: 'Used twice',
    isLend: true,
    dueDateLabel: 'Return by 14 Sep',
  ),
];
