import 'package:flutter/material.dart';

import '../models/chat.dart';
import '../theme/app_theme.dart';
import 'alert_level_selector.dart';
import 'message_bubble.dart';

class ChatThread extends StatefulWidget {
  const ChatThread({super.key, required this.initialMessages, this.hint = 'Message…'});

  final List<ChatMessage> initialMessages;
  final String hint;

  @override
  State<ChatThread> createState() => _ChatThreadState();
}

class _ChatThreadState extends State<ChatThread> {
  late final List<ChatMessage> _messages = List.of(widget.initialMessages);
  final _textController = TextEditingController();
  final _scrollController = ScrollController();
  AlertLevel _selectedLevel = AlertLevel.normal;
  int _nextId = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  void _send() {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          id: 'me-${_nextId++}',
          senderName: 'You',
          avatarIndex: 5,
          text: text,
          time: 'Now',
          alertLevel: _selectedLevel,
          isMe: true,
          animatesEscalation: _selectedLevel == AlertLevel.critical,
        ),
      );
    });

    _textController.clear();
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final message = _messages[index];
              return MessageBubble(key: ValueKey(message.id), message: message);
            },
          ),
        ),
        _Composer(
          controller: _textController,
          hint: widget.hint,
          selectedLevel: _selectedLevel,
          onLevelChanged: (level) => setState(() => _selectedLevel = level),
          onSend: _send,
        ),
      ],
    );
  }
}

class _Composer extends StatelessWidget {
  const _Composer({
    required this.controller,
    required this.hint,
    required this.selectedLevel,
    required this.onLevelChanged,
    required this.onSend,
  });

  final TextEditingController controller;
  final String hint;
  final AlertLevel selectedLevel;
  final ValueChanged<AlertLevel> onLevelChanged;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.sm),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(top: BorderSide(color: theme.colorScheme.outline)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: AlertLevelSelector(selected: selectedLevel, onChanged: onLevelChanged),
            ),
            const SizedBox(height: AppSpacing.sm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    minLines: 1,
                    maxLines: 4,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: hint,
                      isDense: true,
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.4),
                      contentPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.sm),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadii.input),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSubmitted: (_) => onSend(),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                IconButton.filled(onPressed: onSend, icon: const Icon(Icons.arrow_upward_rounded)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
