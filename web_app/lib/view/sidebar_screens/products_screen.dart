import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  static const String id = 'productscreen';
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Text('Product Screens'),
    );
  }
}