import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/fake_story_data.dart';
import '../../theme/app_theme.dart';
import 'processing_screen.dart';

class RecordingScreen extends StatefulWidget {
  const RecordingScreen({super.key, required this.onStoryProcessed});

  final VoidCallback onStoryProcessed;

  @override
  State<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends State<RecordingScreen> {
  bool _isRecording = false;
  int _elapsedSeconds = 0;
  int _questionIndex = 0;

  Timer? _elapsedTimer;
  Timer? _questionTimer;

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _elapsedSeconds = 0;
      _questionIndex = 0;
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

  void _stopRecording() {
    _elapsedTimer?.cancel();
    _questionTimer?.cancel();
    setState(() => _isRecording = false);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProcessingScreen(onStoryProcessed: widget.onStoryProcessed),
      ),
    );
  }

  @override
  void dispose() {
    _elapsedTimer?.cancel();
    _questionTimer?.cancel();
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
              if (_isRecording)
                _FollowUpQuestionCard(question: followUpQuestions[_questionIndex])
              else
                const _PromptCard(),
              const SizedBox(height: AppSpacing.xl),
              _RecordButton(isRecording: _isRecording, onTap: _isRecording ? _stopRecording : _startRecording),
              const SizedBox(height: AppSpacing.md),
              _ElapsedTime(seconds: _elapsedSeconds),
              const SizedBox(height: AppSpacing.lg),
              _WaveformPlaceholder(isActive: _isRecording),
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
