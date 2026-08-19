import 'package:flutter/material.dart';

import '../../data/fake_chat_data.dart';
import '../../models/chat.dart';
import '../../widgets/chat_thread.dart';

class DirectChatScreen extends StatelessWidget {
  const DirectChatScreen({super.key, required this.member});

  final FamilyMember member;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(member.name)),
      body: SafeArea(
        child: ChatThread(
          initialMessages: fakeDirectMessages[member.name] ?? const [],
          hint: 'Message ${member.name}…',
        ),
      ),
    );
  }
}
