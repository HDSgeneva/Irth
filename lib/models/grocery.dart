class ShopOption {
  const ShopOption({required this.shopName, required this.estimatedCostLabel});

  final String shopName;
  final String estimatedCostLabel;
}

class SplitShopResult {
  const SplitShopResult({
    required this.shopAName,
    required this.itemsA,
    required this.shopBName,
    required this.itemsB,
    required this.totalLabel,
    required this.savingsLabel,
  });

  final String shopAName;
  final List<String> itemsA;
  final String shopBName;
  final List<String> itemsB;
  final String totalLabel;
  final String savingsLabel;
}

class GroceryResult {
  const GroceryResult({required this.singleShop, required this.split});

  final ShopOption singleShop;
  final SplitShopResult split;
}
