import 'dart:convert';
import 'dart:io';
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
  late String error;

  ApiError({required String error}) {
    error = this.error;
  }

  ApiError.fromJson(Map<String, dynamic> json) {
    error = json['error'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['error'] = error;
    return data;
  }
}

String _baseUrl = "http://localhost:8000/";
Future<ApiResponse> authenticateUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${_baseUrl}user/login/process'),
      body: {
        'email': email,
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
        print((apiResponse.apiError as ApiError).error);
        apiResponse.apiError = ApiError.fromJson(json.decode(response.body));
        break;
      default:
        print((apiResponse.apiError as ApiError).error);
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
    final response = await http.post(
      Uri.parse('${_baseUrl}user/join/email-check'),
      body: {
        'email': email,
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

Future<ApiResponse> checkNickname(String nickname) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${_baseUrl}user/join/nickname-check'),
      body: {
        'nickname': nickname,
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