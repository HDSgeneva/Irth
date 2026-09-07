import 'package:flutter/material.dart';

import '../../models/story.dart';
import '../../services/story_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import '../../widgets/entity_colors.dart';

class TranscriptScreen extends StatefulWidget {
  const TranscriptScreen({
    super.key,
    required this.storyId,
    required this.transcript,
    required this.onStoryProcessed,
  });

  final String storyId;
  final String transcript;
  final VoidCallback onStoryProcessed;

  @override
  State<TranscriptScreen> createState() => _TranscriptScreenState();
}

class _TranscriptScreenState extends State<TranscriptScreen> {
  final _storyRepository = StoryRepository(supabase);

  StoryDetails? _details;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    try {
      final details = await _storyRepository.extractStoryDetails(widget.storyId);
      if (!mounted) return;
      setState(() => _details = details);
    } catch (_) {
      // Highlighting is a bonus on top of the transcript, so a failure here
      // just leaves the text unhighlighted instead of blocking the user.
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final details = _details;

    return Scaffold(
      appBar: AppBar(title: const Text('Your story')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            if (details != null) ...[
              _Legend(colors: colors),
              const SizedBox(height: AppSpacing.md),
            ],
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text.rich(
                  TextSpan(
                    children: details == null
                        ? [TextSpan(text: widget.transcript)]
                        : highlightedSpans(widget.transcript, details, colors),
                  ),
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface, height: 1.6),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                widget.onStoryProcessed();
                Navigator.of(context).pop();
              },
              child: const Text('Done'),
            ),
          ],
        ),
      ),
    );
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
