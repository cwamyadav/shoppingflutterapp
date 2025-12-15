import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:web_app/global_varriable.dart';
import 'package:web_app/models/sub_category.dart';
import 'package:web_app/services/manage_http_response.dart';

class SubCategoryController {
  // upload function: upload the subcategory
  uploadSubCategory({
    required String categoryId,
    required String categoryName,
    required String subCategoryName,
    required dynamic subCategoyimage,
    required BuildContext context,
  }) async {
    // create container
   CloudinaryPublic cloudinary = CloudinaryPublic(
        dotenv.env['CLOUDINARY_CLOUD_NAME']!,
        dotenv.env['CLOUDINARY_UPLOAD_PRESET']!,
      );
    // upload
    CloudinaryResponse subCategoryImageResponse =
        await cloudinary.uploadFile(CloudinaryFile.fromBytesData(
      subCategoyimage,
      identifier: 'pickedcategoryImage',
      folder: 'categoryImages',
    ));
    // create the url
    String image = subCategoryImageResponse.secureUrl;
    SubCategory subCategory = SubCategory(
        id: "",
        categoryName: categoryName,
        categoryId: categoryId,
        subCategoryName: subCategoryName,
        image: image);
    // post the url
    http.Response response = await http.post(
        Uri.parse('$uri/api/subcategories/'),
        body: subCategory.tojson(),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8'
        });
    // response
    manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'SubCategory Uploaded');
        });
  }

  // load: load the subcategory
  Future<List<SubCategory>> loadSubCategory() async {
    // check the url
    http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories/'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        });
    // in the url if prsent return
    try {
      if (response.statusCode == 200) {
        // check the subcategories
        final List<dynamic> data = jsonDecode(response.body);
        List<SubCategory> subCategories = data
            .map((subcategory) => SubCategory.fromJson(subcategory))
            .toList();
        return subCategories;
      } else {
        throw Exception('Failed to load Subcategories');
      }
    } catch (e) {
      // otherwise give the error
      throw Exception('Error to loadsubcategories');
    }
  }
}
