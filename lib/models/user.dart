import 'dart:convert';
import 'dart:io';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/services/api.dart';

import '../utils/keyFiles.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());


class User {
  User({
    required this.email,
    required this.nickname,
  });

  String email;
  String nickname;

  User.nullInit({
    this.email = "",
    this.nickname = ""
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    email: json["user_email"],
    nickname: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "user_email": email,
    "user_name": nickname,
  };

  // print properties for debug
  void printProperties() {
    debugPrint("email: $email\n");
    debugPrint("nickname: $nickname\n");
  }

  //////////////////////////////////////////////////////////////////////////////[POST] try signUP
  static Future<int> signUp({
    required String email,
    required String password,
    required String nickname,
    required int social
  }) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}user/signup'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_email': email,
          'password': password,
          'user_name': nickname,
          'user_social': social,
        }),
      );

      debugPrint(response.body);
      debugPrint(response.statusCode.toString());
      return response.statusCode;
    } on SocketException {
      // apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
    }
    return 0;
  }

  //////////////////////////////////////////////////////////////////////////////[GET] check email
  static Future<int> checkEmail(String email) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response =
      await http.get(Uri.parse('${baseUrl}user/checkEmail?email=$email'));

      return response.statusCode;
    } on SocketException {
      // apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
    }
    return 0;
  }

  //////////////////////////////////////////////////////////////////////////////[GET] check nickname
  static Future<int> checkNickname(String nickname) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response =
      await http.get(Uri.parse('${baseUrl}user/checkName?name=$nickname'));

      return response.statusCode;
    } on SocketException {
      // apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
    }
    return 0;
  }

  //////////////////////////////////////////////////////////////////////////////[POST] try signUp
  static Future<int> trySignUp(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}user/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'password': password,
          'userEmail': email,
        },
      );

      return response.statusCode;
    } on SocketException {
      apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
    }
    return 0;
  }

  //////////////////////////////////////////////////////////////////////////////[POST] try signIn
  static Future<int> signIn(String email, String password) async {
    ApiResponse apiResponse = ApiResponse();

    try {
      final response = await http.post(
        Uri.parse('${baseUrl}user/login'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'password': password,
          'userEmail': email,
        },
      );

      return response.statusCode;
    } on SocketException {
      apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
    }
    return 0;
  }

  //////////////////////////////////////////////////////////////////////////////[GET] get user's spot and review
  static Future<(List<Spot>, List<Review>)> getUserSpotReview(String email) async {
    final response = await http.get(
      Uri.parse('${baseUrl}user/info?email=$email'),
    );

    print(response.body);

    switch(response.statusCode){
      case 200:
        return parseUserSpotReview((utf8.decode(response.bodyBytes)));
    }

    return (<Spot>[], <Review>[]);
  }

  static (List<Spot>, List<Review>) parseUserSpotReview(String json) {
    List<Spot> spotList = [];
    List<Review> reviewList = [];

    Map<String, dynamic> result = Map<String, dynamic>.from(jsonDecode(json));
    List<dynamic>.from(result["mySpotList"]).forEach((element) {
      spotList.add(
        Spot(
          placeName: element["spotName"],
          address: element["address"],
          spotNum: element["spotCount"],
          coor: NLatLng(double.parse(element["latitude"]), double.parse(element["longitude"])),
          placeId: element["key"].toString(),
        )
      );
    });
    List<dynamic>.from(result["mySpotReviewList"]).forEach((element) {
      reviewList.add(
        Review(
          photo: element["photo"] == null ? [] : List<String>.from(element["photo"]),
          comment: element["comment"],
          reviewedDate: element["reviewDate"],
        )
      );
    });
    return (spotList, reviewList);
  }

}
