import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void manageHttpResponse({
  required http.Response response, // http response from the different request,
  required BuildContext context, // the contexts is to snackbar
  required VoidCallback
      onSuccess, // the callback to excecute to a successfull response
}) {
  // Switch Statement handle to different http status code
  switch (response.statusCode) {
    case 200: // succesfull request
      onSuccess();
      break;
    case 400: // bad request
      showSnackBar(context, jsonDecode(response.body)['msg']);
      break;
    case 500: // error
      showSnackBar(context, json.decode(response.body)['error']);
      break;
    case 201: // resources was created succesfully
      onSuccess();
      break;
  }
}

void showSnackBar(BuildContext context, String titile) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(titile)));
}
