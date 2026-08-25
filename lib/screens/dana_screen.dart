import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'dana/points_tab.dart';
import 'dana/rewards_tab.dart';
import 'dana/tree_tab.dart';

enum _DanaTab { points, tree, rewards }

class DanaScreen extends StatefulWidget {
  const DanaScreen({super.key});

  @override
  State<DanaScreen> createState() => _DanaScreenState();
}

class _DanaScreenState extends State<DanaScreen> {
  _DanaTab _selectedTab = _DanaTab.tree;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dana'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
            child: _DanaSegmentedControl(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
          ),
        ),
      ),
      body: switch (_selectedTab) {
        _DanaTab.points => const PointsTab(),
        _DanaTab.tree => const TreeTab(),
        _DanaTab.rewards => const RewardsTab(),
      },
    );
  }
}

class _DanaSegmentedControl extends StatelessWidget {
  const _DanaSegmentedControl({required this.selected, required this.onChanged});

  final _DanaTab selected;
  final ValueChanged<_DanaTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_DanaTab>(
      segments: const [
        ButtonSegment(value: _DanaTab.points, label: Text('Points'), icon: Icon(Icons.bolt_outlined)),
        ButtonSegment(value: _DanaTab.tree, label: Text('Tree'), icon: Icon(Icons.park_outlined)),
        ButtonSegment(value: _DanaTab.rewards, label: Text('Rewards'), icon: Icon(Icons.card_giftcard_outlined)),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (chosen) => onChanged(chosen.first),
    );
  }
}
