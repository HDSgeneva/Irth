import 'package:flutter/material.dart';

import '../../data/fake_chat_data.dart';
import '../../models/chat.dart';
import '../../theme/app_theme.dart';
import '../../widgets/chat_thread.dart';
import 'direct_chat_screen.dart';

class GroupChatTab extends StatelessWidget {
  const GroupChatTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _MemberPickerRow(
          onMemberTap: (member) {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => DirectChatScreen(member: member)),
            );
          },
        ),
        const Divider(height: 1),
        const Expanded(
          child: ChatThread(initialMessages: fakeGroupMessages, hint: 'Message the family…'),
        ),
      ],
    );
  }
}

class _MemberPickerRow extends StatelessWidget {
  const _MemberPickerRow({required this.onMemberTap});

  final ValueChanged<FamilyMember> onMemberTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              'Tap someone to message them privately',
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          SizedBox(
            height: 76,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                for (final member in fakeFamilyMembers)
                  Padding(
                    padding: const EdgeInsets.only(right: AppSpacing.md),
                    child: _MemberAvatar(member: member, onTap: () => onMemberTap(member)),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.member, required this.onTap});

  final FamilyMember member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final firstName = member.name.split(' ').first;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: 56,
        child: Column(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: AppAvatarColors.forIndex(member.avatarIndex),
              child: Text(member.name[0], style: const TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 4),
            Text(
              firstName,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.textTheme.labelMedium,
            ),
          ],
        ),
      ),
    );
  }
}
