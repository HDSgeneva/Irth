import 'package:flutter/material.dart';

import '../models/chat.dart';

const backupContactName = 'Uncle Tariq';

const currentMemberIndex = 2;

const fakeFamilyMembers = [
  FamilyMember(name: 'Mama Layla', avatarIndex: 0),
  FamilyMember(name: 'Baba Adel', avatarIndex: 1),
  FamilyMember(name: 'Sara', avatarIndex: 2),
  FamilyMember(name: 'Khalid', avatarIndex: 3),
  FamilyMember(name: 'Jeddo Rashid', avatarIndex: 4),
];

const fakeFeedPosts = [
  FeedPost(
    authorName: 'Sara',
    avatarIndex: 2,
    caption: "Found this photo of Jeddo's old shop in Deira, thought everyone would love it 💛",
    timeAgo: '2h ago',
    photoIcon: Icons.storefront_outlined,
  ),
  FeedPost(
    authorName: 'Khalid',
    avatarIndex: 3,
    caption: 'Friday lunch prep is underway. Mama already yelled at me twice.',
    timeAgo: '5h ago',
    photoIcon: Icons.soup_kitchen_outlined,
  ),
  FeedPost(
    authorName: 'Mama Layla',
    avatarIndex: 0,
    caption: 'The garden jasmine finally bloomed this week.',
    timeAgo: '1d ago',
    photoIcon: Icons.local_florist_outlined,
  ),
  FeedPost(
    authorName: 'Jeddo Rashid',
    avatarIndex: 4,
    caption: 'Old picture from the majlis, must be from the 70s.',
    timeAgo: '2d ago',
    photoIcon: Icons.chair_outlined,
  ),
];

const fakeGroupMessages = [
  ChatMessage(
    id: 'g1',
    senderName: 'Mama Layla',
    avatarIndex: 0,
    text: "Don't forget Friday lunch is at our place this week",
    time: '9:02 AM',
    alertLevel: AlertLevel.normal,
  ),
  ChatMessage(
    id: 'g2',
    senderName: 'Khalid',
    avatarIndex: 3,
    text: 'On my way, stuck a bit in traffic',
    time: '9:15 AM',
    alertLevel: AlertLevel.normal,
  ),
  ChatMessage(
    id: 'g3',
    senderName: 'Sara',
    avatarIndex: 2,
    text: 'Bringing dessert 🍮',
    time: '9:16 AM',
    alertLevel: AlertLevel.silent,
  ),
  ChatMessage(
    id: 'g4',
    senderName: 'Baba Adel',
    avatarIndex: 1,
    text: 'Someone needs to pick up Jeddo at 11',
    time: '9:40 AM',
    alertLevel: AlertLevel.urgent,
  ),
];

const fakeDirectMessages = <String, List<ChatMessage>>{
  'Mama Layla': [
    ChatMessage(
      id: 'd-layla-1',
      senderName: 'Mama Layla',
      avatarIndex: 0,
      text: 'Did you eat today?',
      time: '8:10 AM',
      alertLevel: AlertLevel.normal,
    ),
    ChatMessage(
      id: 'd-layla-2',
      senderName: 'Mama Layla',
      avatarIndex: 0,
      text: 'Call me when you can',
      time: '8:11 AM',
      alertLevel: AlertLevel.normal,
    ),
  ],
  'Baba Adel': [
    ChatMessage(
      id: 'd-adel-1',
      senderName: 'Baba Adel',
      avatarIndex: 1,
      text: 'Car is ready for pickup from the garage',
      time: 'Yesterday',
      alertLevel: AlertLevel.silent,
    ),
  ],
  'Sara': [
    ChatMessage(
      id: 'd-sara-1',
      senderName: 'Sara',
      avatarIndex: 2,
      text: 'Sent you the photos from the album, check your gallery',
      time: 'Yesterday',
      alertLevel: AlertLevel.normal,
    ),
  ],
  'Khalid': [
    ChatMessage(
      id: 'd-khalid-1',
      senderName: 'Khalid',
      avatarIndex: 3,
      text: 'Are you free to help me move this weekend?',
      time: '2d ago',
      alertLevel: AlertLevel.normal,
    ),
  ],
  'Jeddo Rashid': [
    ChatMessage(
      id: 'd-rashid-1',
      senderName: 'Jeddo Rashid',
      avatarIndex: 4,
      text: 'Come by after Asr prayer, I want to tell you a story',
      time: '3d ago',
      alertLevel: AlertLevel.normal,
    ),
  ],
};
