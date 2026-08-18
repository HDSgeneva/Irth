import 'package:flutter/material.dart';

import '../../data/fake_story_data.dart';
import '../../models/story.dart';
import '../../theme/app_theme.dart';
import '../../widgets/entity_colors.dart';

class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key, required this.onStoryProcessed});

  final VoidCallback onStoryProcessed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Scaffold(
      appBar: AppBar(title: Text(fakeStory.title)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text(
              'Recorded by ${fakeStory.narrator}',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.md),
            _Legend(colors: colors),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text.rich(
                  TextSpan(children: _spansFor(fakeStory.arabicTranscript, colors)),
                  textDirection: TextDirection.rtl,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface, height: 1.8),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text.rich(
                  TextSpan(children: _spansFor(fakeStory.englishTranscript, colors)),
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurface, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                onStoryProcessed();
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
  }

  List<InlineSpan> _spansFor(List<TranscriptSegment> segments, AppSemanticColors colors) {
    return segments.map((segment) {
      if (segment.type == null) return TextSpan(text: segment.text);
      return TextSpan(
        text: segment.text,
        style: TextStyle(
          backgroundColor: entityColor(colors, segment.type!).withValues(alpha: 0.25),
          fontWeight: FontWeight.w600,
        ),
      );
    }).toList();
  }
}

class _Legend extends StatelessWidget {
  const _Legend({required this.colors});

  final AppSemanticColors colors;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.xs,
      children: [for (final type in EntityType.values) _LegendItem(type: type, colors: colors)],
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.type, required this.colors});

  final EntityType type;
  final AppSemanticColors colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: entityColor(colors, type), shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(entityLabel(type), style: Theme.of(context).textTheme.labelMedium),
      ],
    );
  }
}
