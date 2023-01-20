import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/models/user.dart';

class ApiResponse {
  // _data will hold any response converted into
  // its own object. For example user.
  Object? data;
  // _apiError will hold the error object
  Object? apiError;
}

class ApiError {
  String? error;

  ApiError({
    this.error,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) => ApiError(
        error: json["error"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}

String _baseUrl = "http://3.232.20.72:8080/";
Future<ApiResponse> signUp(
    String email, String password, String nickname, int social) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${_baseUrl}user/signup'),
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

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}

Future<ApiResponse> signIn(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${_baseUrl}user/login/$email'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'password': password,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}

Future<ApiResponse> getUserDetails(String email) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse('${_baseUrl}user/$email'));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}

Future<ApiResponse> checkEmail(String email) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('${_baseUrl}user/check?email=$email'),
    );
    debugPrint(response.body);

    switch (response.statusCode) {
      case 200:
        apiResponse.data = "사용 가능한 이메일입니다.";
        break;
      default:
        apiResponse.apiError = ApiError(error: "이미 사용중인 이메일입니다.");
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}

Future<ApiResponse> checkNickname(String nickname) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${_baseUrl}user/join/nickname-check'),
      body: {
        'user_name': nickname,
      },
    );

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(json.decode(response.body));
        break;
      case 401:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }
  return apiResponse;
}