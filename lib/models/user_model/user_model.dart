import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    required this.id,
    required this.name,
    this.image,
    required this.email,
  });

  String? image;
  String name;
  String id;
  String email;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      image: json['image'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "name": name,
        "email": email,
      };
}
