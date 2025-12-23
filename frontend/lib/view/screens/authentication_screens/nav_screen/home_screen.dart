import 'package:flutter/material.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/banner_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/category_item_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/header_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/popular_product_widget.dart';
import 'package:frontend/view/screens/authentication_screens/nav_screen/widget/reusable_text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderWidget(),
            BannerWidget(),
            CategoryItemWidget(),
            ReusableTextWidget(title: 'Popular Products', subtitle: 'View all'),
            PopularProductWidget(),
          ],
        ),
      ),
    );
  }
}
