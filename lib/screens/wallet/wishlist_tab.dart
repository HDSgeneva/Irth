import 'package:flutter/material.dart';

import '../../data/fake_chat_data.dart';
import '../../data/fake_wishlist_data.dart';
import '../../models/wishlist.dart';
import '../../theme/app_theme.dart';

enum _ViewAs { gifter, owner }

class WishlistTab extends StatefulWidget {
  const WishlistTab({super.key});

  @override
  State<WishlistTab> createState() => _WishlistTabState();
}

class _WishlistTabState extends State<WishlistTab> {
  int _selectedMember = currentMemberIndex;
  _ViewAs _viewAs = _ViewAs.gifter;
  final Set<String> _claimedIds = {};
  final List<WishlistItem> _myItems = List.of(
    fakeWishlistItems.where((item) => item.ownerIndex == currentMemberIndex),
  );

  void _addMyItem(String title) {
    setState(() {
      _myItems.add(
        WishlistItem(
          id: 'own-${DateTime.now().microsecondsSinceEpoch}',
          ownerIndex: currentMemberIndex,
          ownerName: fakeFamilyMembers[currentMemberIndex].name,
          title: title,
          note: '',
          priceLabel: '',
        ),
      );
    });
  }

  Future<void> _promptAddItem() async {
    final controller = TextEditingController();
    final title = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add to your wishlist'),
        content: TextField(controller: controller, autofocus: true, decoration: const InputDecoration(hintText: 'Item name')),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          FilledButton(onPressed: () => Navigator.of(context).pop(controller.text.trim()), child: const Text('Add')),
        ],
      ),
    );
    if (title != null && title.isNotEmpty) _addMyItem(title);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isSelf = _selectedMember == currentMemberIndex;
    final otherItems = fakeWishlistItems.where((item) => item.ownerIndex == _selectedMember).toList();

    return Scaffold(
      floatingActionButton: isSelf
          ? FloatingActionButton(onPressed: _promptAddItem, child: const Icon(Icons.add))
          : null,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Text('Whose wishlist?', style: theme.textTheme.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 76,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (final (index, member) in fakeFamilyMembers.indexed)
                    Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.md),
                      child: _MemberAvatar(
                        name: index == currentMemberIndex ? 'Me' : member.name.split(' ').first,
                        avatarIndex: member.avatarIndex,
                        selected: index == _selectedMember,
                        onTap: () => setState(() => _selectedMember = index),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (isSelf) ...[
              Row(
                children: [
                  Icon(Icons.visibility_off_outlined, size: 14, color: theme.colorScheme.onSurfaceVariant),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      "This is your own list: you never see who's buying what.",
                      style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              for (final item in _myItems)
                Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                  child: _WishlistItemCard(item: item),
                ),
            ] else ...[
              SegmentedButton<_ViewAs>(
                segments: const [
                  ButtonSegment(value: _ViewAs.gifter, label: Text('Gifter view')),
                  ButtonSegment(value: _ViewAs.owner, label: Text('Their own view')),
                ],
                selected: {_viewAs},
                showSelectedIcon: false,
                onSelectionChanged: (chosen) => setState(() => _viewAs = chosen.first),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                _viewAs == _ViewAs.gifter
                    ? "Buying something hides it from them, but other gifters still see it's taken."
                    : "This is what they see: anything already being bought disappears completely.",
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              const SizedBox(height: AppSpacing.md),
              for (final item in otherItems)
                if (_viewAs == _ViewAs.gifter || !_claimedIds.contains(item.id))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: _WishlistItemCard(
                      item: item,
                      claimed: _claimedIds.contains(item.id),
                      showGiftingControls: _viewAs == _ViewAs.gifter,
                      onClaim: () => setState(() => _claimedIds.add(item.id)),
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}

class _MemberAvatar extends StatelessWidget {
  const _MemberAvatar({required this.name, required this.avatarIndex, required this.selected, required this.onTap});

  final String name;
  final int avatarIndex;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(40),
      child: SizedBox(
        width: 60,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(selected ? 2 : 0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: selected ? Border.all(color: theme.colorScheme.primary, width: 2) : null,
              ),
              child: CircleAvatar(
                radius: 22,
                backgroundColor: AppAvatarColors.forIndex(avatarIndex),
                child: Text(name[0], style: const TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 4),
            Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              color: selected ? theme.colorScheme.primary : null,
            )),
          ],
        ),
      ),
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  const _WishlistItemCard({
    required this.item,
    this.claimed = false,
    this.showGiftingControls = false,
    this.onClaim,
  });

  final WishlistItem item;
  final bool claimed;
  final bool showGiftingControls;
  final VoidCallback? onClaim;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600)),
                  if (item.note.isNotEmpty)
                    Text(item.note, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  if (item.priceLabel.isNotEmpty)
                    Text(item.priceLabel, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (showGiftingControls)
              claimed
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: context.appColors.dana.withValues(alpha: 0.16),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text('🎁 Being bought', style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                    )
                  : OutlinedButton(onPressed: onClaim, child: const Text("I'm buying this")),
          ],
        ),
      ),
    );
  }
}
