import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import 'wallet/budget_tab.dart';
import 'wallet/give_lend_tab.dart';
import 'wallet/grocery_tab.dart';
import 'wallet/wishlist_tab.dart';

enum _WalletTab { budget, grocery, wishlist, giveLend }

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  _WalletTab _selectedTab = _WalletTab.budget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.sm),
            child: _WalletSegmentedControl(
              selected: _selectedTab,
              onChanged: (tab) => setState(() => _selectedTab = tab),
            ),
          ),
        ),
      ),
      body: switch (_selectedTab) {
        _WalletTab.budget => const BudgetTab(),
        _WalletTab.grocery => const GroceryTab(),
        _WalletTab.wishlist => const WishlistTab(),
        _WalletTab.giveLend => const GiveLendTab(),
      },
    );
  }
}

class _WalletSegmentedControl extends StatelessWidget {
  const _WalletSegmentedControl({required this.selected, required this.onChanged});

  final _WalletTab selected;
  final ValueChanged<_WalletTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<_WalletTab>(
        segments: const [
          ButtonSegment(value: _WalletTab.budget, label: Text('Budget'), icon: Icon(Icons.account_balance_wallet_outlined)),
          ButtonSegment(value: _WalletTab.grocery, label: Text('Grocery'), icon: Icon(Icons.local_grocery_store_outlined)),
          ButtonSegment(value: _WalletTab.wishlist, label: Text('Wishlist'), icon: Icon(Icons.star_border_outlined)),
          ButtonSegment(value: _WalletTab.giveLend, label: Text('Give'), icon: Icon(Icons.volunteer_activism_outlined)),
        ],
        selected: {selected},
        showSelectedIcon: false,
        onSelectionChanged: (chosen) => onChanged(chosen.first),
      ),
    );
  }
}
