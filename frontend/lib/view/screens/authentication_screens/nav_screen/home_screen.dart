import 'package:flutter/material.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/widget/header_widget.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          HeaderWidget(),
        ],
      ),
    ));
  }
}
