import 'package:flutter/material.dart';

enum AlertLevel { silent, normal, urgent, critical }

class FamilyMember {
  const FamilyMember({required this.name, required this.avatarIndex});

  final String name;
  final int avatarIndex;
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.avatarIndex,
    required this.text,
    required this.time,
    required this.alertLevel,
    this.isMe = false,
    this.animatesEscalation = false,
  });

  final String id;
  final String senderName;
  final int avatarIndex;
  final String text;
  final String time;
  final AlertLevel alertLevel;
  final bool isMe;
  final bool animatesEscalation;
}

class FeedPost {
  const FeedPost({
    required this.authorName,
    required this.avatarIndex,
    required this.caption,
    required this.timeAgo,
    required this.photoIcon,
  });

  final String authorName;
  final int avatarIndex;
  final String caption;
  final String timeAgo;
  final IconData photoIcon;
}
