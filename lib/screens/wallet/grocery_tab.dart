import 'package:flutter/material.dart';

import '../../data/fake_grocery_data.dart';
import '../../theme/app_theme.dart';

class GroceryTab extends StatefulWidget {
  const GroceryTab({super.key});

  @override
  State<GroceryTab> createState() => _GroceryTabState();
}

class _GroceryTabState extends State<GroceryTab> {
  final _listController = TextEditingController();
  bool _showResult = false;

  void _addByVoice() {
    setState(() {
      _listController.text = _listController.text.isEmpty
          ? fakeVoiceGroceryItems
          : '${_listController.text}\n$fakeVoiceGroceryItems';
    });
  }

  void _findBestShop() {
    if (_listController.text.trim().isEmpty) return;
    setState(() => _showResult = true);
  }

  void _sendToDriver() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Sent to Khalid, he has the car this evening')),
    );
  }

  @override
  void dispose() {
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text('This week\'s list', style: theme.textTheme.headlineSmall),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          controller: _listController,
          maxLines: 6,
          onChanged: (_) => setState(() => _showResult = false),
          decoration: const InputDecoration(
            hintText: 'Type items, one per line…',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: _addByVoice,
          icon: const Icon(Icons.mic_none_outlined),
          label: const Text('Add by voice'),
        ),
        const SizedBox(height: AppSpacing.md),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: _findBestShop, child: const Text('Find the best shop')),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (_showResult) ...[
          _SingleShopCard(),
          const SizedBox(height: AppSpacing.sm),
          _SplitShopCard(onSendToDriver: _sendToDriver),
        ],
      ],
    );
  }
}

class _SingleShopCard extends StatelessWidget {
  const _SingleShopCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shop = fakeGroceryResult.singleShop;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Icon(Icons.storefront_outlined, color: theme.colorScheme.primary),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('One shop', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  Text(shop.shopName, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            Text(shop.estimatedCostLabel, style: theme.textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

class _SplitShopCard extends StatelessWidget {
  const _SplitShopCard({required this.onSendToDriver});

  final VoidCallback onSendToDriver;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final split = fakeGroceryResult.split;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Split across two shops', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: context.appColors.success.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    split.savingsLabel,
                    style: theme.textTheme.labelMedium?.copyWith(color: context.appColors.success, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(split.totalLabel, style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            _ShopSplitRow(shopName: split.shopAName, items: split.itemsA),
            const SizedBox(height: AppSpacing.sm),
            _ShopSplitRow(shopName: split.shopBName, items: split.itemsB),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onSendToDriver,
                icon: const Icon(Icons.local_shipping_outlined),
                label: const Text('Send to driver'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopSplitRow extends StatelessWidget {
  const _ShopSplitRow({required this.shopName, required this.items});

  final String shopName;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(color: context.appColors.band, borderRadius: BorderRadius.circular(AppRadii.input)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(shopName, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 2),
          Text(items.join(' · '), style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
        ],
      ),
    );
  }
}
