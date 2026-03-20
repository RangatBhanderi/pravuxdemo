// To parse this JSON data, do
//
//     final userListModel = userListModelFromJson(jsonString);

import 'dart:convert';

List<UserListModel> userListModelFromJson(String str) => List<UserListModel>.from(json.decode(str).map((x) => UserListModel.fromJson(x)));

String userListModelToJson(List<UserListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserListModel {
  String? name;
  String? email;
  String? password;
  dynamic? phoneNumber;
  String? lastCallAt;
  String? id;

  UserListModel({
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.lastCallAt,
    this.id,
  });

  factory UserListModel.fromJson(Map<String, dynamic> json) => UserListModel(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    phoneNumber: json["phoneNumber"],
    lastCallAt: json["lastCallAt"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "phoneNumber": phoneNumber,
    "lastCallAt": lastCallAt,
    "id": id,
  };
}
