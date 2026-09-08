import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../data/fake_story_data.dart';
import '../../models/story.dart';
import '../../theme/app_theme.dart';

class WeeklyPlayScreen extends StatefulWidget {
  const WeeklyPlayScreen({super.key, required this.storyGenerated});

  final bool storyGenerated;

  @override
  State<WeeklyPlayScreen> createState() => _WeeklyPlayScreenState();
}

class _WeeklyPlayScreenState extends State<WeeklyPlayScreen> {
  final _player = AudioPlayer(playerId: 'weekly_play_answer');

  int? _selected;
  bool _revealed = false;
  PlayerState _playerState = PlayerState.stopped;

  @override
  void initState() {
    super.initState();
    _player.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _playerState = state);
    });
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _select(int index) {
    if (_revealed) return;
    setState(() => _selected = index);
  }

  Future<void> _reveal() async {
    setState(() => _revealed = true);
    await _player.stop();
    await _player.play(AssetSource(fakeStory.answerAudioAsset));
  }

  Future<void> _togglePlayback() async {
    if (_playerState == PlayerState.playing) {
      await _player.pause();
    } else {
      await _player.resume();
    }
  }

  void _answerAgain() {
    _player.stop();
    setState(() {
      _selected = null;
      _revealed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.storyGenerated) return const _EmptyPlayState();

    final trivia = fakeStory.trivia;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _TriviaCard(
            narrator: fakeStory.narrator,
            trivia: trivia,
            selected: _selected,
            revealed: _revealed,
            onSelect: _select,
          ),
          const SizedBox(height: AppSpacing.lg),
          if (!_revealed)
            ElevatedButton(
              onPressed: _selected == null ? null : _reveal,
              child: const Text('Reveal the answer'),
            )
          else
            _AnswerAudioCard(
              correct: _selected == trivia.correctIndex,
              label: fakeStory.answerAudioLabel,
              playing: _playerState == PlayerState.playing,
              onToggle: _togglePlayback,
              onAnswerAgain: _answerAgain,
            ),
        ],
      ),
    );
  }
}

class _TriviaCard extends StatelessWidget {
  const _TriviaCard({
    required this.narrator,
    required this.trivia,
    required this.selected,
    required this.revealed,
    required this.onSelect,
  });

  final String narrator;
  final TriviaQuestion trivia;
  final int? selected;
  final bool revealed;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: AppColors.ghaf700, borderRadius: AppRadii.cardBorderRadius),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
            ),
            child: const Text(
              "This week's majlis",
              style: TextStyle(color: Colors.white, fontSize: 11.5, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            "FROM ${narrator.toUpperCase()}'S STORY",
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.6),
              fontSize: 10,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            trivia.prompt,
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600, height: 1.3),
          ),
          const SizedBox(height: AppSpacing.lg),
          for (final (index, option) in trivia.options.indexed)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: _OptionPill(
                label: option,
                isSelected: selected == index,
                isCorrect: index == trivia.correctIndex,
                revealed: revealed,
                colors: colors,
                onTap: () => onSelect(index),
              ),
            ),
        ],
      ),
    );
  }
}

class _OptionPill extends StatelessWidget {
  const _OptionPill({
    required this.label,
    required this.isSelected,
    required this.isCorrect,
    required this.revealed,
    required this.colors,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final bool isCorrect;
  final bool revealed;
  final AppSemanticColors colors;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var background = Colors.white.withValues(alpha: 0.12);
    Border? border;
    Widget? trailing;

    if (revealed && isCorrect) {
      background = colors.success.withValues(alpha: 0.85);
      trailing = const Icon(Icons.check_circle, color: Colors.white, size: 18);
    } else if (revealed && isSelected && !isCorrect) {
      background = colors.nida.withValues(alpha: 0.85);
      trailing = const Icon(Icons.cancel, color: Colors.white, size: 18);
    } else if (!revealed && isSelected) {
      border = Border.all(color: Colors.white, width: 1.5);
    }

    return InkWell(
      onTap: revealed ? null : onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(14), border: border),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),
              ),
            ),
            ?trailing,
          ],
        ),
      ),
    );
  }
}

class _AnswerAudioCard extends StatelessWidget {
  const _AnswerAudioCard({
    required this.correct,
    required this.label,
    required this.playing,
    required this.onToggle,
    required this.onAnswerAgain,
  });

  final bool correct;
  final String label;
  final bool playing;
  final VoidCallback onToggle;
  final VoidCallback onAnswerAgain;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  correct ? Icons.celebration_outlined : Icons.info_outline,
                  color: correct ? colors.success : colors.khor,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    correct ? 'You got it right' : "Not quite — here's the real answer",
                    style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                InkWell(
                  onTap: onToggle,
                  borderRadius: BorderRadius.circular(24),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: theme.colorScheme.primary, shape: BoxShape.circle),
                    child: Icon(playing ? Icons.pause : Icons.play_arrow, color: Colors.white),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    label,
                    style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: onAnswerAgain, child: const Text('Answer again')),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyPlayState extends StatelessWidget {
  const _EmptyPlayState();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.style_outlined, size: 40, color: theme.colorScheme.onSurfaceVariant),
              const SizedBox(height: AppSpacing.sm),
              Text('No round yet', style: theme.textTheme.headlineSmall, textAlign: TextAlign.center),
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Record your first story and a trivia round will be waiting for the family.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
