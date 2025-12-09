import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:forntend/global_varriables.dart';
import 'package:forntend/model/user.dart';
import 'package:forntend/services/manage_http_response.dart';
import 'package:forntend/view/screens/authentication_screens/login_screen.dart';
import 'package:forntend/view/screens/authentication_screens/main_screen.dart';
import 'package:http/http.dart' as http;

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
          onSuccess: () {
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
}
