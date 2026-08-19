import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'bonds/feed_screen.dart';
import 'bonds/group_chat_tab.dart';

enum _BondsTab { feed, chat }

class BondsScreen extends StatefulWidget {
  const BondsScreen({super.key});

  @override
  State<BondsScreen> createState() => _BondsScreenState();
}

class _BondsScreenState extends State<BondsScreen> {
  _BondsTab _selectedTab = _BondsTab.feed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bonds'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: _BondsSegmentedControl(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
          ),
        ),
      ),
      body: switch (_selectedTab) {
        _BondsTab.feed => const FeedScreen(),
        _BondsTab.chat => const GroupChatTab(),
      },
    );
  }
}

class _BondsSegmentedControl extends StatelessWidget {
  const _BondsSegmentedControl({required this.selected, required this.onChanged});

  final _BondsTab selected;
  final ValueChanged<_BondsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_BondsTab>(
      segments: const [
        ButtonSegment(
          value: _BondsTab.feed,
          label: Text('Feed'),
          icon: Icon(Icons.photo_library_outlined),
        ),
        ButtonSegment(
          value: _BondsTab.chat,
          label: Text('Chat'),
          icon: Icon(Icons.forum_outlined),
        ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (chosen) => onChanged(chosen.first),
    );
  }
}
