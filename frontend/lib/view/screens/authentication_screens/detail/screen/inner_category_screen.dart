import 'package:flutter/material.dart';
import 'package:forntend/model/category.dart';
import 'package:forntend/view/screens/authentication_screens/detail/screen/widget/inner_content_widget.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/cart_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/category_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/favorite_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/store_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/user_screen.dart';

class InnerCategoryScreen extends StatefulWidget {
  final Category category;
  const InnerCategoryScreen({required this.category, super.key});

  @override
  State<InnerCategoryScreen> createState() => _InnerCategoryScreenState();
}

class _InnerCategoryScreenState extends State<InnerCategoryScreen> {
  int pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      InnerCategoryContentWidget(
        category: widget.category,
      ),
      FavoriteScreen(),
      CategoryScreen(),
      StoreScreen(),
      CartScreen(),
      UserScreen(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        currentIndex: pageIndex,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/home.png', width: 25),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/love.png', width: 25),
              label: "favroite"),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/mart.png', width: 25),
              label: 'Category'),
          BottomNavigationBarItem(
              icon: Image.asset(
                'assets/icons/mart.png',
                width: 25,
              ),
              label: 'store'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/cart.png', width: 25),
              label: 'Cart'),
          BottomNavigationBarItem(
              icon: Image.asset('assets/icons/user.png', width: 25),
              label: 'User'),
        ],
      ),
      body: pages[pageIndex],
    );
  }
}