class WishlistItem {
  const WishlistItem({
    required this.id,
    required this.ownerIndex,
    required this.ownerName,
    required this.title,
    required this.note,
    required this.priceLabel,
  });

  final String id;
  final int ownerIndex;
  final String ownerName;
  final String title;
  final String note;
  final String priceLabel;
}
