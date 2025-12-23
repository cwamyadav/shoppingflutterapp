import 'dart:convert';
import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/sub_category.dart';
import 'package:http/http.dart' as http;

class SubCategoryController {
  // upload function: upload the subcategory

  // load: load the subcategory
  Future<List<SubCategory>> loadSubCategorybyCategoryName(
      String categoryName) async {
    // check the url
    http.Response response = await http.get(
        Uri.parse('$uri/api/category/$categoryName/subcategories/'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        });
    // in the url if prsent return
    try {
      if (response.statusCode == 200) {
        // check the subcategories
        final List<dynamic> data = jsonDecode(response.body);
        if (data.isNotEmpty) {
          List<SubCategory> subCategories = data
              .map((subcategory) => SubCategory.fromJson(subcategory))
              .toList();
          return subCategories;
        } else {
          print('SubCategories not found');
          return [];
        }
      } else if (response.statusCode == 404) {
        print('Subcategories not found');
        return [];
      } else {
        print('failed to fetch subCategories');
        return [];
      }
    } catch (e) {
      print('error fetching categories $e');
      return [];
    }
  }
}
