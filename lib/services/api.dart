import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/models/review.dart';
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

Future<ApiResponse> getUserDetails(String email) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse('${_baseUrl}user/login/$email'));

    switch (response.statusCode) {
      case 200:
        apiResponse.data =
            User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
      case 401:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError =
            ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
      default:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError =
            ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
  }
  return apiResponse;
}



Future<ApiResponse> getPost(String email) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response =
        await http.get(Uri.parse('${_baseUrl}spot/userSpot?email=$email'));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = json.decode(response.body);
        // apiResponse.data = jsonDecode(utf8.decode(response.bodyBytes));
        // apiResponse.data = Post.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
      case 401:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError =
            ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
      default:
        debugPrint((apiResponse.apiError as ApiError).error);
        apiResponse.apiError =
            ApiError.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
        break;
    }
  } on SocketException {
    apiResponse.apiError = ApiError(error: "서버 오류입니다.\n 다시 시도해주세요.");
  }
  return apiResponse;
}
