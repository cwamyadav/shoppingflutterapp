import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductController {
  Future<List<Product>> loadProducts() async {
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/api/popular-products/'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        List<Product> products = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        return products;
      } else {
        throw Exception('failed to load products');
      }
    } catch (e) {
      throw Exception('Error loading product :$e');
    }
  }

//  load product by category
  Future<List<Product>> loadProductsByCategory(String category) async {
    // request: same method used as backend

    // response
    // if available
    try {
      http.Response response = await http.get(
          Uri.parse('$uri/api/products-by-category/$category'),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          });
      if (response.statusCode == 200) {
        // convert json to object
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;

        // object to map

        List<Product> product = data
            .map((product) => Product.fromMap(product as Map<String, dynamic>))
            .toList();
        // return the project
        return product;
      } else {
        throw Exception('falied to load products');
      }
    } catch (e) {
      throw Exception('Error loading product:$e');
    }
  }



}
