import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'family_tree_screen.dart';
import 'recording_screen.dart';
import 'weekly_play_screen.dart';

enum _RootsTab { record, tree, play }

class RootsScreen extends StatefulWidget {
  const RootsScreen({super.key});

  @override
  State<RootsScreen> createState() => _RootsScreenState();
}

class _RootsScreenState extends State<RootsScreen> {
  _RootsTab _selectedTab = _RootsTab.record;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roots'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: _RootsSegmentedControl(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
          ),
        ),
      ),
      body: switch (_selectedTab) {
        _RootsTab.record => const RecordingScreen(),
        _RootsTab.tree => const FamilyTreeScreen(),
        _RootsTab.play => const WeeklyPlayScreen(),
      },
    );
  }
}

class _RootsSegmentedControl extends StatelessWidget {
  const _RootsSegmentedControl({required this.selected, required this.onChanged});

  final _RootsTab selected;
  final ValueChanged<_RootsTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_RootsTab>(
      segments: const [
        ButtonSegment(
          value: _RootsTab.record,
          label: Text('Record'),
          icon: Icon(Icons.mic_none_outlined),
        ),
        ButtonSegment(
          value: _RootsTab.tree,
          label: Text('Tree'),
          icon: Icon(Icons.account_tree_outlined),
        ),
        ButtonSegment(
          value: _RootsTab.play,
          label: Text('Play'),
          icon: Icon(Icons.style_outlined),
        ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (chosen) => onChanged(chosen.first),
    );
  }
}
