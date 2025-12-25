import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/controller/product_controller.dart';
import 'package:frontend/provider/product_provider.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/product_item_widget.dart';

class PopularProductWidget extends ConsumerStatefulWidget {
  const PopularProductWidget({super.key});

  @override
  ConsumerState<PopularProductWidget> createState() =>
      _PopularProductWidgetState();
}

class _PopularProductWidgetState extends ConsumerState<PopularProductWidget> {
  Future<void> _fetchProduct() async {
    final ProductController _productController = ProductController();
    try {
      final products = await _productController.loadProducts();
      ref.read(productProvider.notifier).setProducts(products);
    } catch (e) {
      print('$e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);
    return SizedBox(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            final prodcut = products[index];
            return ProductItemWidget(product: prodcut);
          }),
    );
  }
}
