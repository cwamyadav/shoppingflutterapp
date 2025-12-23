import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/user.dart';
import 'package:frontend/provider/uers_provider.dart';
import 'package:frontend/services/manage_http_response.dart';
import 'package:frontend/view/screens/authentication_screens/login_screen.dart';
import 'package:frontend/view/screens/authentication_screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/// an object that store the state of provider
final providerContainer = ProviderContainer();

class AuthController {
  Future<void> signupUser({
    required context,
    required String email,
    required String fullname,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        email: email,
        password: password,
        fullname: fullname,
        state: '',
        city: '',
        locality: '',
        token: '',
      );
      http.Response response = await http.post(Uri.parse('$uri/api/signup/'),
          // body: user
          //     .tojson(), // conver to user object to json for the request body
          body: jsonEncode(user.toMap()),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LoginScreen()));
            showSnackBar(context, 'Account has been created for you');
          });
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> signinUser({
    required context,
    required String email,
    required String password,
    //  required WidgetRef ref,
  }) async {
    try {
      http.Response response = await http.post(Uri.parse('$uri/api/signin/'),
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8',
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () async {
            // create shared preferences instance for token and data storage
            SharedPreferences preferences =
                await SharedPreferences.getInstance();

            // extract authentication token from the response body
            String token = jsonDecode(response.body)['token'];

            // store the authentication token from securely in sharedpreferences

            await preferences.setString('auth-token', token);

            // Encode the userdata recieved from backend as json
            final userJson = jsonEncode(jsonDecode(response.body)['user']);

            // update the application state with the user data using riverpod
            providerContainer.read(userProvider.notifier).setUser(userJson);

            // store the data in sharedPrefrences for the future use
            await preferences.setString('user', userJson);

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
            showSnackBar(context, 'logged in');
          });
    } catch (e) {
      print('error: $e');
    }
  }

  Future<void> signout({required context}) async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      // remove the token and user
      preferences.remove('auth-token');
      preferences.remove('user');
      // clear the state
      providerContainer.read(userProvider.notifier).signout();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
        (route) => false,
      );
      showSnackBar(context, 'Logout succssfully');
    } catch (e) {
      showSnackBar(context, 'error signing out:$e');
    }
  }

  //updated user location

  Future<void> updateUserLocation({
    required context,
    required String state,
    required String city,
    required String locality,
    required String id,
  }) async {
    try {
      // send response with the updated data
      http.Response response = await http.put(
        Uri.parse('$uri/api/users/$id'),
        body: jsonEncode(
          {
            "state": state,
            "city": city,
            "locality": locality,
          },
        ),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () async {
          // json string to dart map convert:
          final updatedUser = jsonDecode(response.body);
          // access Sharedpreference for local storage
          SharedPreferences preferences = await SharedPreferences.getInstance();
          // updated data convert map to json String
          final userJson = jsonEncode(updatedUser);
          // update the application state within riverpod
          providerContainer.read(userProvider.notifier).setUser(userJson);

          // store the updated data in sharedpreferences
          await preferences.setString('user', userJson);

          Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => MainScreen()),
                (route) => false);
            showSnackBar(context, 'Updated successfully');
        },
      );
    } catch (e) {
      showSnackBar(context, 'failed to upload');
    }
  }
}
