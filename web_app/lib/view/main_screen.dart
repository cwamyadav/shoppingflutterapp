import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:web_app/view/sidebar_screens/buyer_screen.dart';
import 'package:web_app/view/sidebar_screens/category_screen.dart';
import 'package:web_app/view/sidebar_screens/orders_screen.dart';
import 'package:web_app/view/sidebar_screens/products_screen.dart';
import 'package:web_app/view/sidebar_screens/upload_banner_screen.dart';
import 'package:web_app/view/sidebar_screens/vendors_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget _selectedScreen = CategoryScreen();

  screenSelectRoute(item) {
    setState(() {
      switch (item.route) {
        case BuyerScreen.id:
          _selectedScreen = BuyerScreen();
          break;
        case CategoryScreen.id:
          _selectedScreen = CategoryScreen();
          break;
        case OrderScreen.id:
          _selectedScreen = OrderScreen();
          break;
        case ProductScreen.id:
          _selectedScreen = ProductScreen();
          break;
        case UploadBannerScreen.id:
          _selectedScreen = UploadBannerScreen();
          break;
        default:
          _selectedScreen = VendorsScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: _selectedScreen,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      sideBar: SideBar(
          header: Container(
              alignment: Alignment.center,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 20),
              color: Colors.black,
              child: Text(
                'Multi vendor Admin',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              )),
          items: [
            AdminMenuItem(
              title: 'vendor',
              route: BuyerScreen.id,
              icon: CupertinoIcons.person_3,
            ),
            AdminMenuItem(
                title: 'Buyers', route: "", icon: CupertinoIcons.person),
            AdminMenuItem(
                title: 'Orders',
                route: OrderScreen.id,
                icon: CupertinoIcons.shopping_cart),
            AdminMenuItem(
                title: 'Categories',
                route: CategoryScreen.id,
                icon: Icons.category),
            AdminMenuItem(
                title: 'Upload Banner',
                route: UploadBannerScreen.id,
                icon: Icons.upload),
            AdminMenuItem(
                title: 'Products', route: ProductScreen.id, icon: Icons.store),
          ],
          selectedRoute: CategoryScreen.id,
          onSelected: (item) {
            screenSelectRoute(item);
          }),
    );
  }
}
