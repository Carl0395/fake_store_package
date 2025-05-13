import 'dart:convert';

class UserModel {
  final int? id;
  final String? username;
  final String? email;
  final String? password;

  UserModel({this.id, this.username, this.email, this.password});

  UserModel copyWith({
    int? id,
    String? username,
    String? email,
    String? password,
  }) => UserModel(
    id: id ?? this.id,
    username: username ?? this.username,
    email: email ?? this.email,
    password: password ?? this.password,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json["id"],
    username: json["username"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "email": email,
    "password": password,
  };

  @override
  String toString() {
    final prettyJson = JsonEncoder.withIndent('  ').convert(toJson());
    return prettyJson;
  }
}
