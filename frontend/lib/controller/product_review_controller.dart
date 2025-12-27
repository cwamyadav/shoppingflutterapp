import 'package:frontend/global_varriables.dart';
import 'package:frontend/model/product_review.dart';
import 'package:frontend/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class ProductReviewController {
  // upload
  // name, review, product/orderid,
  // {buyerId,email,fullname,productId,rating,review}
  uploadReview({
    required String buyerId,
    required String email,
    required String fullname,
    required String productId,
    required double rating,
    required String review,
    required context,
  }) async {
    try {
      final ProductReview productReview = ProductReview(
        id: "",
        buyerId: buyerId,
        email: email,
        fullname: fullname,
        productId: productId,
        rating: rating,
        review: review,
      );
      http.Response response = await http.post(Uri.parse('$uri/api/prodcut-review'),
          body: productReview.toJson(),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8",
          });
      manageHttpResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'you had added a review');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
