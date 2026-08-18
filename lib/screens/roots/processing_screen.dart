import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'transcript_screen.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key, required this.onStoryProcessed});

  final VoidCallback onStoryProcessed;

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen> {
  static const _steps = [
    'Listening and writing it down',
    'Translating to English',
    'Finding people, places and dates',
  ];

  int _stepsDone = 0;

  @override
  void initState() {
    super.initState();
    _run();
  }

  Future<void> _run() async {
    for (var i = 0; i < _steps.length; i++) {
      await Future.delayed(const Duration(milliseconds: 550));
      if (!mounted) return;
      setState(() => _stepsDone = i + 1);
    }
    await Future.delayed(const Duration(milliseconds: 400));
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => TranscriptScreen(onStoryProcessed: widget.onStoryProcessed),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < _steps.length; i++)
                _StepRow(label: _steps[i], done: i < _stepsDone),
            ],
          ),
        ),
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({required this.label, required this.done});

  final String label;
  final bool done;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? context.appColors.success : theme.colorScheme.outline,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: theme.textTheme.bodyLarge),
        ],
      ),
    );
  }
}
