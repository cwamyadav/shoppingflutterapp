// {buyerId,email,fullname,productId,rating,review}
import 'dart:convert';

class ProductReview {
  final String id;
  final String buyerId;
  final String email;
  final String fullname;
  final String productId;
  final double rating;
  final String review;

  ProductReview({
    required this.id,
    required this.buyerId,
    required this.email,
    required this.fullname,
    required this.productId,
    required this.rating,
    required this.review,
  });
// object to map
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      "id": id,
      "buyerId": buyerId,
      "email": email,
      "fullname": fullname,
      "productId": productId,
      "rating": rating,
      "review": review,
    };
  }

  // convert map to json
  String toJson() => jsonEncode(tomap());

// json to map
  factory ProductReview.fromMap(Map<String, dynamic> map) {
    return ProductReview(
        id: map["_id"] as String,
        buyerId: map["buyerId"] as String,
        email: map["email"] as String,
        fullname: map["fullname"] as String,
        productId: map["productId"] as String,
        rating: map["rating"] as double,
        review: map["review"] as String);
  }

  factory ProductReview.fromJson(String source) =>
      ProductReview.fromMap(json.decode(source) as Map<String, dynamic>);
}
