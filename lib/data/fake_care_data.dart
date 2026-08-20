import 'package:flutter/material.dart';

import '../models/care_reminder.dart';

const fakeCareReminders = [
  CareReminder(
    id: 'c1',
    title: "Jeddo Rashid's blood pressure pills",
    icon: Icons.medication_outlined,
    scheduleLabel: 'Every day · 8:00 AM',
    primaryName: 'Baba Adel',
    primaryAvatarIndex: 1,
    backupName: 'Khalid',
    backupAvatarIndex: 3,
  ),
  CareReminder(
    id: 'c2',
    title: 'School pickup',
    icon: Icons.directions_car_filled_outlined,
    scheduleLabel: 'Weekdays · 2:00 PM',
    primaryName: 'Mama Layla',
    primaryAvatarIndex: 0,
    backupName: 'Sara',
    backupAvatarIndex: 2,
  ),
  CareReminder(
    id: 'c3',
    title: "Jeddo Rashid's cardiology follow-up",
    icon: Icons.event_available_outlined,
    scheduleLabel: 'Thu 8 Aug · 10:00 AM',
    primaryName: 'Khalid',
    primaryAvatarIndex: 3,
    backupName: 'Baba Adel',
    backupAvatarIndex: 1,
  ),
];
