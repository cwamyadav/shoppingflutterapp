import 'package:flutter/material.dart';
import 'package:frontend/controller/auth_controller.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              AuthController().signout(context: context);
            },
            child: Text('Signout')),
      ),
    );
  }
}
