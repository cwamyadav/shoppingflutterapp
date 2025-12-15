import 'package:flutter/material.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/cart_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/home_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/category_screen.dart';
import 'package:forntend/view/screens/authentication_screens/nav_screen/user_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    UserScreen(),
  ];
  int _pageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          currentIndex: _pageIndex,
          onTap: (value) {
            setState(() {
              _pageIndex = value;
            });
          },
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/home.png', width: 25),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/mart.png', width: 25),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/cart.png', width: 25),
                label: 'Cart'),
            BottomNavigationBarItem(
                icon: Image.asset('assets/icons/user.png', width: 25),
                label: 'User'),
          ]),
      body: _pages[_pageIndex],
    );
  }
}
