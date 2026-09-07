import 'package:flutter/material.dart';

import '../../services/story_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import 'transcript_screen.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key, required this.storyId, required this.onStoryProcessed});

  final String storyId;
  final VoidCallback onStoryProcessed;

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  final _storyRepository = StoryRepository(supabase);

  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _transcribe();
  }

  Future<void> _transcribe() async {
    try {
      final transcript = await _storyRepository.transcribeStory(widget.storyId);
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => TranscriptScreen(
            transcript: transcript,
            onStoryProcessed: widget.onStoryProcessed,
          ),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() => _errorMessage = 'Could not transcribe your story. Please try again.');
    }
  }

  void _retry() {
    setState(() => _errorMessage = null);
    _transcribe();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Center(
            child: _errorMessage == null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: AppSpacing.md),
                      Text('Transcribing your story...', style: theme.textTheme.bodyLarge),
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error_outline, color: theme.colorScheme.error, size: 40),
                      const SizedBox(height: AppSpacing.sm),
                      Text(_errorMessage!, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
                      const SizedBox(height: AppSpacing.md),
                      OutlinedButton(onPressed: _retry, child: const Text('Try again')),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
