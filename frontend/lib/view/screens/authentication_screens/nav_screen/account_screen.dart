import 'package:flutter/material.dart';
import 'package:frontend/view/screens/authentication_screens/detail/screen/order_screen.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async{
              // AuthController().signout(context: context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => OrderScreen()));
            },
            child: Text('My Orders')),
      ),
    );
  }
}
