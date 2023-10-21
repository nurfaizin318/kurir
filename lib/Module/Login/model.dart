// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String id;
    String nama;
    String username;
    String password;

    UserModel({
        required this.id,
        required this.nama,
        required this.username,
        required this.password,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "username": username,
        "password": password,
    };
}
