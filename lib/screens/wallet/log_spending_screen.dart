import 'package:flutter/material.dart';

import '../../data/fake_budget_data.dart';
import '../../models/budget.dart';
import '../../theme/app_theme.dart';

class LogSpendingScreen extends StatefulWidget {
  const LogSpendingScreen({super.key});

  @override
  State<LogSpendingScreen> createState() => _LogSpendingScreenState();
}

class _LogSpendingScreenState extends State<LogSpendingScreen> {
  final _amountController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedPot = fakeBudgetPots.first.name;

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  void _submitManualEntry() {
    final amount = double.tryParse(_amountController.text);
    if (amount == null) return;
    Navigator.of(context).pop(
      SpendingEntry(
        id: 'manual-${DateTime.now().microsecondsSinceEpoch}',
        potName: _selectedPot,
        amount: amount,
        note: _noteController.text.trim().isEmpty ? 'Manual entry' : _noteController.text.trim(),
        dateLabel: 'Just now',
      ),
    );
  }

  Future<void> _openReceiptScan() async {
    final entry = await showModalBottomSheet<SpendingEntry>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadii.sheetTop)),
      ),
      builder: (_) => const _ReceiptResultSheet(),
    );
    if (entry != null && mounted) {
      Navigator.of(context).pop(entry);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Log spending')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: _openReceiptScan,
                icon: const Icon(Icons.camera_alt_outlined),
                label: const Text('Photo a receipt'),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(child: Divider(color: theme.colorScheme.outline)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                  child: Text('or enter it yourself', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ),
                Expanded(child: Divider(color: theme.colorScheme.outline)),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('Amount (AED)', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(hintText: '0.00', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Pot', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final pot in fakeBudgetPots)
                  ChoiceChip(
                    label: Text(pot.name),
                    selected: _selectedPot == pot.name,
                    onSelected: (_) => setState(() => _selectedPot = pot.name),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Note', style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: AppSpacing.xs),
            TextField(
              controller: _noteController,
              decoration: const InputDecoration(hintText: 'What was it for?', border: OutlineInputBorder()),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(onPressed: _submitManualEntry, child: const Text('Add expense')),
            ),
          ],
        ),
      ),
    );
  }
}

class _ReceiptResultSheet extends StatelessWidget {
  const _ReceiptResultSheet();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final receipt = fakeReceiptResult;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.check_circle, color: context.appColors.success),
                const SizedBox(width: AppSpacing.xs),
                Text('Receipt read', style: theme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Card(
              color: context.appColors.band,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(receipt.merchant, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                        ),
                        Text(
                          'AED ${receipt.amount.toStringAsFixed(2)}',
                          style: theme.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Suggested pot: ${receipt.suggestedPot}',
                      style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Divider(height: 1),
                    const SizedBox(height: AppSpacing.sm),
                    for (final item in receipt.lineItems)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Text('• $item', style: theme.textTheme.bodyMedium),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(
                    SpendingEntry(
                      id: 'receipt-${DateTime.now().microsecondsSinceEpoch}',
                      potName: receipt.suggestedPot,
                      amount: receipt.amount,
                      note: receipt.merchant,
                      dateLabel: 'Just now',
                      fromReceipt: true,
                    ),
                  );
                },
                child: const Text('Add to my spending'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
