import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

import '../../data/fake_story_data.dart';
import '../../services/family_repository.dart';
import '../../services/story_repository.dart';
import '../../supabase/supabase_client.dart';
import '../../theme/app_theme.dart';
import 'processing_screen.dart';

enum _SaveStatus { idle, saving, success, error }

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key, required this.onStoryProcessed});

  final VoidCallback onStoryProcessed;

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  final _audioRecorder = AudioRecorder();
  final _familyRepository = FamilyRepository(supabase);
  final _storyRepository = StoryRepository(supabase);

  bool _isRecording = false;
  int _elapsedSeconds = 0;
  int _questionIndex = 0;

  _SaveStatus _saveStatus = _SaveStatus.idle;
  String? _errorMessage;

  Timer? _elapsedTimer;
  Timer? _questionTimer;

  Future<void> _startRecording() async {
    final hasPermission = await _audioRecorder.hasPermission();
    if (!hasPermission) {
      setState(() {
        _saveStatus = _SaveStatus.error;
        _errorMessage = 'Microphone permission is needed to record a story.';
      });
      return;
    }

    final tempDir = await getTemporaryDirectory();
    final path = '${tempDir.path}/story_${DateTime.now().millisecondsSinceEpoch}.m4a';
    await _audioRecorder.start(const RecordConfig(), path: path);

    setState(() {
      _isRecording = true;
      _elapsedSeconds = 0;
      _questionIndex = 0;
      _saveStatus = _SaveStatus.idle;
      _errorMessage = null;
    });

    _elapsedTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _elapsedSeconds++);
    });

    _questionTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      setState(() {
        _questionIndex = (_questionIndex + 1) % followUpQuestions.length;
      });
    });
  }

  Future<void> _stopRecording() async {
    _elapsedTimer?.cancel();
    _questionTimer?.cancel();

    final path = await _audioRecorder.stop();
    setState(() {
      _isRecording = false;
      _saveStatus = _SaveStatus.saving;
    });

    if (path == null) {
      setState(() {
        _saveStatus = _SaveStatus.error;
        _errorMessage = 'No recording was captured. Please try again.';
      });
      return;
    }

    try {
      final membership = await _familyRepository.myFamily();
      if (membership == null) {
        throw Exception('You need to be part of a family to save a story.');
      }

      await _storyRepository.saveRecording(
        familyId: membership.familyId,
        userId: _familyRepository.currentUser!.id,
        audioFile: File(path),
      );

      if (!mounted) return;
      setState(() => _saveStatus = _SaveStatus.success);

      await Future.delayed(const Duration(seconds: 1));
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ProcessingScreen(onStoryProcessed: widget.onStoryProcessed),
        ),
      );
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _saveStatus = _SaveStatus.error;
        _errorMessage = 'Could not save your story. Please try again.';
      });
    }
  }

  void _dismissError() {
    setState(() {
      _saveStatus = _SaveStatus.idle;
      _errorMessage = null;
    });
  }

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    _questionTimer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              switch (_saveStatus) {
                _SaveStatus.saving => const _SavingCard(),
                _SaveStatus.success => const _SuccessCard(),
                _SaveStatus.error => _ErrorCard(message: _errorMessage!, onDismiss: _dismissError),
                _SaveStatus.idle when _isRecording =>
                  _FollowUpQuestionCard(question: followUpQuestions[_questionIndex]),
                _SaveStatus.idle => const _PromptCard(),
              },
              if (_saveStatus == _SaveStatus.idle) ...[
                const SizedBox(height: AppSpacing.xl),
                _RecordButton(isRecording: _isRecording, onTap: _isRecording ? _stopRecording : _startRecording),
                const SizedBox(height: AppSpacing.md),
                _ElapsedTime(seconds: _elapsedSeconds),
                const SizedBox(height: AppSpacing.lg),
                _WaveformPlaceholder(isActive: _isRecording),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _PromptCard extends StatelessWidget {
  const _PromptCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: context.appColors.band,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('PROMPT OF THE WEEK', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.xs),
            Text('Tell us about the first house you lived in.', style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _FollowUpQuestionCard extends StatelessWidget {
  const _FollowUpQuestionCard({required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: AppColors.ghaf900,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Text(
              'ASK NEXT',
              style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.dana),
            ),
            const SizedBox(height: AppSpacing.sm),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Text(
                question,
                key: ValueKey(question),
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SavingCard extends StatelessWidget {
  const _SavingCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.md),
            Text('Saving your story...', style: theme.textTheme.bodyLarge),
          ],
        ),
      ),
    );
  }
}

class _SuccessCard extends StatelessWidget {
  const _SuccessCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.check_circle, color: context.appColors.success, size: 40),
            const SizedBox(height: AppSpacing.sm),
            Text('Story saved', style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _ErrorCard extends StatelessWidget {
  const _ErrorCard({required this.message, required this.onDismiss});

  final String message;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: theme.colorScheme.error, size: 40),
            const SizedBox(height: AppSpacing.sm),
            Text(message, textAlign: TextAlign.center, style: theme.textTheme.bodyLarge),
            const SizedBox(height: AppSpacing.md),
            OutlinedButton(onPressed: onDismiss, child: const Text('Try again')),
          ],
        ),
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({required this.isRecording, required this.onTap});

  final bool isRecording;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final nida = context.appColors.nida;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: isRecording ? 108 : 96,
        height: isRecording ? 108 : 96,
        decoration: BoxDecoration(color: nida, shape: BoxShape.circle),
        child: Icon(
          isRecording ? Icons.stop_rounded : Icons.mic_rounded,
          color: Colors.white,
          size: 36,
        ),
      ),
    );
  }
}

class _ElapsedTime extends StatelessWidget {
  const _ElapsedTime({required this.seconds});

  final int seconds;

  @override
  Widget build(BuildContext context) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return Text('$minutes:$secs', style: Theme.of(context).textTheme.headlineMedium);
  }
}

class _WaveformPlaceholder extends StatelessWidget {
  const _WaveformPlaceholder({required this.isActive});

  final bool isActive;

  static const _barHeights = [0.4, 0.7, 1.0, 0.55, 0.85, 0.3, 0.62, 0.9, 0.45, 0.22];

  @override
  Widget build(BuildContext context) {
    final activeColor = Theme.of(context).colorScheme.primary;
    final idleColor = Theme.of(context).colorScheme.outlineVariant;
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (final h in _barHeights)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Container(
                width: 3,
                height: 40 * h,
                decoration: BoxDecoration(
                  color: isActive ? activeColor : idleColor,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
