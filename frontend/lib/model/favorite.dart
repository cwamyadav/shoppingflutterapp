import 'dart:convert';

class Favorite {
  final String productName;
  final int productPrice;
  final String category;
  final List<String> image;
  final String vendorId;
   int quantity;
  final int productQuantity;
  final String productId;
  final String desc;
  final String fullName;

  Favorite({
    required this.productName,
    required this.productPrice,
    required this.category,
    required this.image,
    required this.vendorId,
    required this.quantity,
    required this.productQuantity,
    required this.productId,
    required this.desc,
    required this.fullName,
  });

// Object to map,
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "productName": productName,
      "productPrice": productPrice,
      "category": category,
      "image": image,
      "vendorId": vendorId,
      "quantity": quantity,
      "productQuantity": productQuantity,
      "productId": productId,
      "desc": desc,
      "fullname": fullName,
    };
  }

  // map to json
  String toJson() => jsonEncode(toMap());

  // json to map
  factory Favorite.fromMap(Map<String, dynamic> map) {
    return Favorite(
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      category: map['category'] as String,
      image: map['image'] as List<String>,
      vendorId: map['vendorId'] as String,
      quantity: map['quantity'] as int,
      productQuantity: map['productQuantity'] as int,
      productId: map[' productId'] as String,
      desc: map['desc'] as String,
      fullName: map['fullName'] as String,
    );
  }
}
