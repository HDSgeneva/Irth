import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'branches/calendar_tab.dart';
import 'branches/care_tab.dart';
import 'branches/plan_tab.dart';

enum _BranchesTab { calendar, plan, care }

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  State<BranchesScreen> createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  _BranchesTab _selectedTab = _BranchesTab.calendar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Branches'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.md,
              0,
              AppSpacing.md,
              AppSpacing.sm,
            ),
            child: _BranchesSegmentedControl(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
          ),
        ),
      ),
      body: switch (_selectedTab) {
        _BranchesTab.calendar => const CalendarTab(),
        _BranchesTab.plan => const PlanTab(),
        _BranchesTab.care => const CareTab(),
      },
    );
  }
}

class _BranchesSegmentedControl extends StatelessWidget {
  const _BranchesSegmentedControl({required this.selected, required this.onChanged});

  final _BranchesTab selected;
  final ValueChanged<_BranchesTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_BranchesTab>(
      segments: const [
        ButtonSegment(
          value: _BranchesTab.calendar,
          label: Text('Calendar'),
          icon: Icon(Icons.calendar_month_outlined),
        ),
        ButtonSegment(
          value: _BranchesTab.plan,
          label: Text('Plan'),
          icon: Icon(Icons.auto_awesome_outlined),
        ),
        ButtonSegment(
          value: _BranchesTab.care,
          label: Text('Care'),
          icon: Icon(Icons.favorite_outline),
        ),
      ],
      selected: {selected},
      showSelectedIcon: false,
      onSelectionChanged: (chosen) => onChanged(chosen.first),
    );
  }
}
