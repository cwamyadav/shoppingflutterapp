import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/provider/uers_provider.dart';
import 'package:frontend/view/screens/authentication_screens/login_screen.dart';
import 'package:frontend/view/screens/authentication_screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  await dotenv.load(
      fileName: "assets/configs/.env"); // load environment variables

  runApp(
    // flutter app wrap with provider: for managing the state,
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

// root widget extends with consumer widget: for consuming the state change by the rivepod
class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  // This widget is the root of your application.

  // this function check the token if available then set the userdata,
  Future<void> _checkTokenAndSetUser(WidgetRef ref) async {
    // obtain an data instance from the sharedpreference
    SharedPreferences preferences = await SharedPreferences.getInstance();
    // retrived the authenticationtoken and store use data locally
    String? token = preferences.getString('auth-token');
    String? userJson = preferences.getString('user');

    // if both token and user data available, update the usestate
    if (token != null && userJson != null) {
      ref.read(userProvider.notifier).setUser(userJson);
    } else {
      ref.read(userProvider.notifier).signout();
    }
  }

// The widget is the root of your application
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: _checkTokenAndSetUser(ref),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final user = ref.watch(userProvider);
          return user != null ? MainScreen() : LoginScreen();
        },
      ),
    );
  }
}
