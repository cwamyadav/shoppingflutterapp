import 'dart:convert';

class User {
  final String id;
  final String email;
  final String password;
  final String fullname;
  final String state;
  final String locality;
  final String city;
  final String token;
  User(
      {required this.id,
      required this.email,
      required this.password,
      required this.fullname,
      required this.state,
      required this.city,
      required this.locality,
      required this.token,});

  // serilization: object to map format,
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "id": id,
      "fullname": fullname,
      "email": email,
      "password": password,
      "state": state,
      "locality": locality,
      "city": city,
      "token":token,
    };
  }

// seriliation: map to json
  String tojson() => jsonEncode(toMap());

// deserilization: json object to map convert,
//user for showing the name email at screen , factory is used
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map["_id"] as String? ?? '',
      fullname: map["fullname"] as String? ?? "",
      email: map["email"] as String? ?? "",
      state: map["state"] as String? ?? "",
      city: map["city"] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }

  factory User.fromJson(String source) =>
      User.fromMap(jsonDecode(source) as Map<String, dynamic>);
}
