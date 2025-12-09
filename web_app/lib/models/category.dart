import 'dart:convert';

class Category {
  final String id;
  final String name;
  final String image;
  final String banner;
  Category(
      {required this.id,
      required this.name,
      required this.image,
      required this.banner});
// object to map convert
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      "id": id,
      "name": name,
      "image": image,
      "banner": banner,
    };
  }

// map to json convert
  String tojson() => jsonEncode(tomap());
  
// json to map convert
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
        id: map['id'] as String,
        name: map['name'] as String,
        image: map['image'] as String,
        banner: map['banner'] as String);
  }
// map to object convert
  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));
}
