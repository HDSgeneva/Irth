import 'package:flutter/material.dart';

import '../../data/fake_story_data.dart';
import '../../theme/app_theme.dart';

class FamilyTreeScreen extends StatelessWidget {
  const FamilyTreeScreen({super.key, required this.storyGenerated});

  final bool storyGenerated;

  @override
  Widget build(BuildContext context) {
    if (!storyGenerated) return const SizedBox.expand();

    final theme = Theme.of(context);
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'Added from "${fakeStory.title}"',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final (index, name) in fakeStory.extractedNames.indexed)
            _FamilyMemberTile(name: name, color: AppAvatarColors.forIndex(index)),
        ],
      ),
    );
  }
}

class _FamilyMemberTile extends StatelessWidget {
  const _FamilyMemberTile({required this.name, required this.color});

  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            child: Text(name[0], style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(name, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
