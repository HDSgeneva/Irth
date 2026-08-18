import 'package:flutter/material.dart';

import '../../data/fake_story_data.dart';
import '../../theme/app_theme.dart';

enum _OptionState { idle, correct, wrong }

class WeeklyPlayScreen extends StatefulWidget {
  const WeeklyPlayScreen({super.key, required this.storyGenerated});

  final bool storyGenerated;

  @override
  State<WeeklyPlayScreen> createState() => _WeeklyPlayScreenState();
}

class _WeeklyPlayScreenState extends State<WeeklyPlayScreen> {
  int? _selected;

  @override
  Widget build(BuildContext context) {
    if (!widget.storyGenerated) return const SizedBox.expand();

    final theme = Theme.of(context);
    final trivia = fakeStory.trivia;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          Text(
            'From "${fakeStory.title}"',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(trivia.prompt, style: theme.textTheme.headlineSmall),
          const SizedBox(height: AppSpacing.md),
          for (final (index, option) in trivia.options.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _OptionTile(
                label: option,
                state: _stateFor(index, trivia.correctIndex),
                onTap: _selected == null ? () => setState(() => _selected = index) : null,
              ),
            ),
        ],
      ),
    );
  }

  _OptionState _stateFor(int index, int correctIndex) {
    if (_selected == null) return _OptionState.idle;
    if (index == correctIndex) return _OptionState.correct;
    if (index == _selected) return _OptionState.wrong;
    return _OptionState.idle;
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({required this.label, required this.state, required this.onTap});

  final String label;
  final _OptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    var borderColor = theme.colorScheme.outline;
    Color? fillColor;
    if (state == _OptionState.correct) {
      borderColor = colors.success;
      fillColor = colors.success.withValues(alpha: 0.12);
    } else if (state == _OptionState.wrong) {
      borderColor = colors.nida;
      fillColor = colors.nida.withValues(alpha: 0.12);
    }

    return InkWell(
      onTap: onTap,
      borderRadius: AppRadii.buttonBorderRadius,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm + 2),
        decoration: BoxDecoration(
          color: fillColor ?? theme.colorScheme.surface,
          borderRadius: AppRadii.buttonBorderRadius,
          border: Border.all(color: borderColor),
        ),
        child: Text(label, style: theme.textTheme.bodyLarge),
      ),
    );
  }
}
