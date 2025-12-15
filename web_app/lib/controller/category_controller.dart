import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/global_varriable.dart';
import 'package:web_app/models/category.dart';
import 'package:web_app/services/manage_http_response.dart';

class CategoryController {
  uploadCategory({
    // this function tells how to upload image and their response
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required BuildContext context,
  }) async {
    try {
      // step-1, create cloudinary instance
      CloudinaryPublic cloudinary = CloudinaryPublic(
        dotenv.env['CLOUDINARY_CLOUD_NAME']!,
        dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
      );
      // step -2upload the image
      CloudinaryResponse imageResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
        pickedImage,
        identifier: 'pickedcategoryImage',
        folder: 'categoryImages',
      ));

      // print(imageResponse);
      // s3- make the url
      String image = imageResponse.secureUrl;
      //
      //
      // again upload
      CloudinaryResponse bannerResponse =
          await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
        pickedBanner,
        identifier: 'pickedcategoryBanner',
        folder: 'categoryImages',
      ));
      // print(bannerResponse);
      String banner = bannerResponse.secureUrl; // again make banner
      // createa object who contain image and banner url with category name
      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );
      // object in json format send to database
      http.Response response = await http.post(
          Uri.parse('$uri/api/categories/'),
          body: category.tojson(),
          headers: <String, String>{
            "Content-Type": 'application/json; charset=UTF-8'
          });
      // what happend in database: uploaded or not/ error
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'uploaded category');
          });
    } catch (e) {
      print('Error /uploading to cloudinary: $e');
    }
  }

// Load all categories from the server API
  Future<List<Category>> loadCategories() async {
    try {
      final response = await http.get(
        Uri.parse('$uri/api/categories/'),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        },
      );
      // print(response.body); // Print response body to check its structure
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print(e);
      throw Exception('Error loading Categories: $e');
    }
  }
}
