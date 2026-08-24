import '../models/grocery.dart';

const fakeVoiceGroceryItems = 'Milk\nEggs\nBread\nTomatoes\nChicken breast\nRice\nOlive oil\nYogurt';

const fakeGroceryResult = GroceryResult(
  singleShop: ShopOption(shopName: 'Carrefour Al Wahda', estimatedCostLabel: 'AED 186'),
  split: SplitShopResult(
    shopAName: 'Lulu Hypermarket',
    itemsA: ['Milk', 'Eggs', 'Yogurt', 'Tomatoes'],
    shopBName: 'Carrefour Al Wahda',
    itemsB: ['Chicken breast', 'Rice', 'Olive oil', 'Bread'],
    totalLabel: 'AED 164',
    savingsLabel: 'Save AED 22',
  ),
);
