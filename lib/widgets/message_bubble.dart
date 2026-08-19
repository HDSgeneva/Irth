import 'dart:async';

import 'package:flutter/material.dart';

import '../data/fake_chat_data.dart';
import '../models/chat.dart';
import '../theme/app_theme.dart';
import 'alert_level_style.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({super.key, required this.message});

  final ChatMessage message;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  static const _startMinutes = 10;

  Timer? _timer;
  int _minutesLeft = _startMinutes;
  bool _escalated = false;

  @override
  void initState() {
    super.initState();
    if (widget.message.animatesEscalation) {
      _timer = Timer.periodic(const Duration(milliseconds: 900), _tick);
    }
  }

  void _tick(Timer timer) {
    if (_minutesLeft <= 1) {
      timer.cancel();
      setState(() => _escalated = true);
      return;
    }
    setState(() => _minutesLeft--);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final message = widget.message;
    final level = message.alertLevel;
    final color = alertLevelColor(context, level);

    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        margin: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: message.isMe ? theme.colorScheme.primary.withValues(alpha: 0.10) : theme.cardColor,
          borderRadius: AppRadii.cardBorderRadius,
          border: Border.all(
            color: level == AlertLevel.critical ? color.withValues(alpha: 0.5) : theme.colorScheme.outline,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  message.senderName,
                  style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: AppSpacing.xs),
                Icon(alertLevelIcon(level), size: 13, color: color),
                const Spacer(),
                Text(
                  message.time,
                  style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(message.text, style: theme.textTheme.bodyMedium),
            if (message.animatesEscalation) ...[
              const SizedBox(height: AppSpacing.xs),
              _EscalationStatus(escalated: _escalated, minutesLeft: _minutesLeft),
            ],
          ],
        ),
      ),
    );
  }
}

class _EscalationStatus extends StatelessWidget {
  const _EscalationStatus({required this.escalated, required this.minutesLeft});

  final bool escalated;
  final int minutesLeft;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.appColors;
    final color = escalated ? colors.nida : colors.amber;

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Container(
        key: ValueKey(escalated),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 4),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              escalated ? Icons.phone_forwarded_outlined : Icons.hourglass_bottom_rounded,
              size: 13,
              color: color,
            ),
            const SizedBox(width: 4),
            Text(
              escalated ? 'Escalated to $backupContactName' : 'No response — escalating in $minutesLeft min',
              style: theme.textTheme.labelMedium?.copyWith(color: color, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
