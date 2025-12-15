import 'dart:convert';

class BannerModel {
  final String id;
  final String image;

  BannerModel({
    required this.id,
    required this.image,
  });
  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      "id": id,
      "image": image,
    };
  }

// map to json convert
  String tojson() => jsonEncode(tomap());

// json to map convert
  factory BannerModel.fromJson(Map<String, dynamic> map) {
    return BannerModel(
      id: map['_id'] as String,
      image: map['image'] as String,
    );
  }
// // map to object convert
//   factory BannerModel.fromJson(String source) =>
//       BannerModel.fromMap(json.decode(source));
}
