// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
enum Gender { male, female, none }

class User {
  User({
    this.email,
    this.password,
    this.nickname,
  });

  String? email;
  String? password;
  String? nickname;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: json["email"],
        password: json["password"],
        nickname: json["nickname"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
        "nickname": nickname,
      };

  // print properties for debug
  void printProperties() {
    debugPrint("email: $email\n");
    debugPrint("password: $password\n");
    debugPrint("nickname: $nickname\n");
  }
}
