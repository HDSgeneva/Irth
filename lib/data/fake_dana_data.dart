import 'package:flutter/material.dart';

import '../models/dana.dart';

const fakeCurrentPoints = 7800;

const fakeGhafLevels = [
  GhafLevelInfo(name: 'Badhra', arabicName: 'بذرة', threshold: 0, unlockDescription: 'Core app'),
  GhafLevelInfo(
    name: 'Nabta',
    arabicName: 'نبتة',
    threshold: 1500,
    unlockDescription: 'Family crest builder, 6 majlis themes',
  ),
  GhafLevelInfo(
    name: 'Fasīla',
    arabicName: 'فسيلة',
    threshold: 5000,
    unlockDescription: 'Timeline view, story card frames, Live Majlis mode',
  ),
  GhafLevelInfo(
    name: 'Ghaf',
    arabicName: 'غاف',
    threshold: 15000,
    unlockDescription: 'Dalla Tier-3 trip planning, unlimited archive search',
  ),
  GhafLevelInfo(
    name: "Ghaf Mu'ammar",
    arabicName: 'غاف معمّر',
    threshold: 40000,
    unlockDescription: 'Annual printed Irth Book, family documentary reel',
  ),
];

final fakeCurrentLevelIndex = levelIndexForPoints(fakeCurrentPoints, fakeGhafLevels);

const fakePointsActivities = [
  PointsActivity(
    title: 'Recorded a story',
    subtitle: 'The house in Al Ain',
    points: 50,
    icon: Icons.mic_none_outlined,
    dateLabel: 'Today',
  ),
  PointsActivity(
    title: 'Showed up to dinner',
    subtitle: "Lunch at Umm Rashid's",
    points: 60,
    icon: Icons.restaurant_outlined,
    dateLabel: 'Yesterday',
  ),
  PointsActivity(
    title: 'Stayed under budget',
    subtitle: 'Eating Out pot, this month',
    points: 25,
    icon: Icons.savings_outlined,
    dateLabel: '2 days ago',
  ),
  PointsActivity(
    title: 'Gave something away',
    subtitle: 'Baby clothes, 0-6 months',
    points: 30,
    icon: Icons.volunteer_activism_outlined,
    dateLabel: '3 days ago',
  ),
  PointsActivity(
    title: 'Played the weekly round',
    subtitle: 'Answered all 5 questions',
    points: 20,
    icon: Icons.style_outlined,
    dateLabel: 'This week',
  ),
  PointsActivity(
    title: 'Confirmed a tree node',
    subtitle: 'Added Saif to the family tree',
    points: 15,
    icon: Icons.account_tree_outlined,
    dateLabel: 'Last week',
  ),
];

const fakeRewards = [
  Reward(
    id: 'r1',
    title: 'Seedling app icon',
    subtitle: 'A green sprout icon for your home screen',
    icon: Icons.emoji_nature_outlined,
    levelIndex: 0,
    kind: RewardKind.appReward,
  ),
  Reward(
    id: 'r2',
    title: 'Founder badge',
    subtitle: 'Shows on your profile',
    icon: Icons.workspace_premium_outlined,
    levelIndex: 0,
    kind: RewardKind.appReward,
  ),
  Reward(
    id: 'r3',
    title: 'Family crest builder',
    subtitle: 'Design a crest for the family home screen',
    icon: Icons.shield_outlined,
    levelIndex: 1,
    kind: RewardKind.appReward,
  ),
  Reward(
    id: 'r4',
    title: '6 majlis themes',
    subtitle: 'New colour themes for play night',
    icon: Icons.palette_outlined,
    levelIndex: 1,
    kind: RewardKind.appReward,
  ),
  Reward(
    id: 'r5',
    title: 'AED 25 café voucher',
    subtitle: 'Repose Coffee, any branch',
    icon: Icons.local_cafe_outlined,
    levelIndex: 2,
    kind: RewardKind.voucher,
  ),
  Reward(
    id: 'r6',
    title: '2 cinema tickets',
    subtitle: 'VOX Cinemas, any showtime',
    icon: Icons.local_movies_outlined,
    levelIndex: 3,
    kind: RewardKind.voucher,
  ),
  Reward(
    id: 'r7',
    title: 'AED 150 restaurant voucher',
    subtitle: 'Al Fanar Restaurant',
    icon: Icons.restaurant_outlined,
    levelIndex: 4,
    kind: RewardKind.voucher,
  ),
];
