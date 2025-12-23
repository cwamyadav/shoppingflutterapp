import 'dart:convert';

class Product {
  final String id;
  final String productName;
  final int productPrice;
  final int quantity;
  final String desc;
  final String category;
  final String vendorId;
  final String vendorName;
  final String subCategory;
  final List<String> images;

  Product({
    required this.id,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.desc,
    required this.category,
    required this.vendorId,
    required this.vendorName,
    required this.subCategory,
    required this.images,
  });
// Object to map,
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id":id, 
      "productName": productName,
      "productPrice": productPrice,
      "quantity": quantity,
      "desc": desc,
      "category": category,
      "vendorId": vendorId,
      "vendorName": vendorName,
      "subCategory": subCategory,
      "images": images,
    };
  }

  // map to json
  String toJson() => jsonEncode(toMap());

  // json to map
  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['_id'] as String,
      productName: map['productName'] as String,
      productPrice: map['productPrice'] as int,
      quantity: map['quantity'] as int,
      desc: map['desc'] as String,
      category: map['category'] as String,
      vendorId: map['vendorId'] as String,
      vendorName: map['vendorName'] as String,
      subCategory: map['subCategory'] as String,
      images:List<String>.from(map['images'] as List<dynamic>) ,
    );
  }
}

