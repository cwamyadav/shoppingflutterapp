// id
// categoryname
// categoryid
// image
// subcategoryname
import 'dart:convert';

class SubCategory {
  final String id;
  final String categoryId;
  final String categoryName;
  final String subCategoryName;
  final String image;

  SubCategory({
    required this.id,
    required this.categoryName,
    required this.categoryId,
    required this.subCategoryName,
    required this.image,
  });

  // object to  map
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      "id": id,
      "categoryId": categoryId,
      "categoryName": categoryName,
      "subCategoryName": subCategoryName,
      "image": image,
    };
  }

// map to json: convert
  String tojson() => jsonEncode(tomap());

// json to object convertfactory Category.fromJson(Map<String, dynamic> map) {
  factory SubCategory.fromJson(Map<String, dynamic> map) {
    return SubCategory(
      id: map['_id'] as String,
      categoryId: map['categoryId'] as String,
      categoryName: map['categoryName'] as String,
      image: map['image'] as String,
      subCategoryName: map['subCategoryName'] as String,
      // extract banner field from map
    );
  }
}
