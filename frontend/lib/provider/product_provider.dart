import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/model/product.dart';

class ProductProvider extends StateNotifier<List<Product>> {
  ProductProvider() : super([]);

  // set the state of the product
  void setProducts(List<Product> products) {
    state = products;
  }
}

final productProvider = StateNotifierProvider<ProductProvider, List<Product>>(
    (ref) => ProductProvider());
