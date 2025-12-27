import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/cart.dart';

// state notifier manage the state
// here : state notifier mange a map where key String, and value is Cart,
class FavoriteNotifier extends StateNotifier<Map<String, Favorite>> {
  // at initial time inside map(state)is empty( cart is empty)
  FavoriteNotifier() : super({});
  // method for add the product into cart
  void addProductToFavorite({
    required String productName,
    required int productPrice,
    required String category,
    required List<String> image,
    required String vendorId,
    required int quantity,
    required int productQuantity,
    required String productId,
    required String desc,
    required String fullName,
  }) {
    state[productId] = Favorite(
      productName: productName,
      productPrice: productPrice,
      category: category,
      image: image,
      vendorId: vendorId,
      quantity: quantity,
      productQuantity: productQuantity,
      productId: productId,
      desc: desc,
      fullName: fullName,
    );
  }

  // remove item from the cart
  void removeFavoriteItem(String productId) {
    state.remove(productId);
    // notifylistener: show the ui
    state = {...state};
  }


// method to get a value of favorite Item
  Map<String, Favorite> get getFavoriteItems => state;
}

final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, Map<String, Favorite>>(
        (ref) => FavoriteNotifier());
