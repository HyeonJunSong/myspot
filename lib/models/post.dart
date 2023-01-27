
import 'package:flutter/material.dart';

class Post {
  String? spotName; //스팟
  String? email; //사용자id
  String? category; //카테고리
  //키워드
  String? comment; //한줄평
  //사진
  //폴더
  //날짜

  Post({
    this.spotName,
    this.email,
    this.category,
    this.comment,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        email: json["email"],
        spotName: json["spotName"],
        category: json["spotCategory"],
        comment: json["spotComment"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "spotName": spotName,
      };

  // print properties for debug
  void printProperties() {
    debugPrint("email: $email\n");
    debugPrint("spotName: $spotName\n");
  }
}
