import 'package:flutter/material.dart';

class BuyerScreen extends StatefulWidget {
  static const String id = '\vendor-screen';
 
  const BuyerScreen({super.key});

  @override
  State<BuyerScreen> createState() => _BuyerScreenState();
}

class _BuyerScreenState extends State<BuyerScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Buyer Screen'),
    );
  }
}
