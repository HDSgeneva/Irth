import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class TranscriptScreen extends StatelessWidget {
  const TranscriptScreen({super.key, required this.transcript, required this.onStoryProcessed});

  final String transcript;
  final VoidCallback onStoryProcessed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Your story')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Text(
                  transcript,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface, height: 1.6),
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
}
