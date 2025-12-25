import 'dart:convert';

import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/order.dart';
import 'package:frontend/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class OrderController {
  uploadOrders({
    required String id,
    required String fullName,
    required String email,
    required String state,
    required String city,
    required String locality,
    required String productName,
    required int productPrice,
    required int quantity,
    required String category,
    required String image,
    required String buyerId,
    required String vendorId,
    required bool processing,
    required bool delivered,
    required context,
  }) async {
    try {
      Order order = Order(
          id: id,
          fullName: fullName,
          email: email,
          state: state,
          city: city,
          locality: locality,
          productName: productName,
          productPrice: productPrice,
          quantity: quantity,
          category: category,
          image: image,
          buyerId: buyerId,
          vendorId: vendorId,
          processing: processing,
          delivered: delivered);

      http.Response response = await http.post(Uri.parse('$uri/api/orders/'),
          body: order.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json;charset=UTF-8"
          });

      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'order placed succesfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<Order>> loadOrders({required String buyerId}) async {
    try {
      http.Response response = await http
          .get(Uri.parse('$uri/api/orders/$buyerId'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      });
      if (response.statusCode == 200) {
        // convert json to object
        final List<dynamic> data = jsonDecode(response.body);

        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();
        // return the project
        return orders;
      } else {
        throw Exception('falied to load products');
      }
    } catch (e) {
      throw Exception('Error loading orders');
    }
  }

  // delete order
  Future<void> deleteOrder({required String id, required context}) async {
    try {
      http.Response response = await http
          .delete(Uri.parse('$uri/api/orders/$id'), headers: <String, String>{
        "Content-Type": "application/json; charset=UTF-8"
      });

      // handle the http request
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Order Deleted Successfully');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
