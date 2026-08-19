import 'package:flutter/material.dart';

import '../../data/fake_chat_data.dart';
import '../../models/chat.dart';
import '../../theme/app_theme.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Row(
          children: [
            Icon(Icons.lock_outline, size: 14, color: theme.colorScheme.onSurfaceVariant),
            const SizedBox(width: 4),
            Text(
              'Visible only to your family',
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        for (final post in fakeFeedPosts)
          Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.md),
            child: _FeedPostCard(post: post),
          ),
      ],
    );
  }
}

class _FeedPostCard extends StatelessWidget {
  const _FeedPostCard({required this.post});

  final FeedPost post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final avatarColor = AppAvatarColors.forIndex(post.avatarIndex);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: avatarColor,
                  child: Text(post.authorName[0], style: const TextStyle(color: Colors.white)),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.authorName, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                      Text(
                        post.timeAgo,
                        style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          AspectRatio(
            aspectRatio: 16 / 10,
            child: Container(
              color: avatarColor.withValues(alpha: 0.18),
              alignment: Alignment.center,
              child: Icon(post.photoIcon, size: 48, color: avatarColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.cardPadding),
            child: Text(post.caption, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
