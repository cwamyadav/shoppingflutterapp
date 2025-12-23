import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/cart.dart';

// state notifier manage the state
// here : state notifier mange a map where key String, and value is Cart,
class CartNotifier extends StateNotifier<Map<String, Cart>> {
  // at initial time inside map(state)is empty( cart is empty)
  CartNotifier() : super({});
  // method for add the product into cart
  void addProductToCart({
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
    // if alread product in the cart
    if (state.containsKey(productId)) {
      // copy that and extends onely quantity,
      state = {
        ...state, // copy all previous item
        productId: Cart(
          productName: state[productId]!.productName,
          productPrice: state[productId]!.productPrice,
          category: state[productId]!.category,
          image: state[productId]!.image,
          vendorId: state[productId]!.vendorId,
          quantity: state[productId]!.quantity + 1,
          productQuantity: state[productId]!.productQuantity,
          productId: state[productId]!.productId,
          desc: state[productId]!.desc,
          fullName: state[productId]!.fullName,
        )
      };
    } else {
      // if not avaialbe create a cart object and
      state = {
        ...state,
        productId: Cart(
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
        )
      };
    }
  }

// increment
  void incrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity++;
      // notify the listener
      state = {...state};
    }
  }

// decrement
  void decrementCartItem(String productId) {
    if (state.containsKey(productId)) {
      state[productId]!.quantity--;
      state = {...state};
    }
  }

  // remove item from the cart
  void removeCartItem(String productId) {
    state.remove(productId);
    // notifylistener: show the ui
    state = {...state};
  }

  // calculate to total amount of items we have in cart
  double calculateTotalAmount() {
    double totalamount = 0.0;
    state.forEach((productId, cartItem) {
      totalamount += cartItem.quantity * cartItem.productPrice;
    });
    return totalamount;
  }

  Map<String, Cart> get getCartItems => state;
}

final cartProvider = StateNotifierProvider<CartNotifier, Map<String, Cart>>(
    (ref) => CartNotifier());
