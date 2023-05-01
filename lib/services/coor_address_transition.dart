import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myspot/utils/keyFiles.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'api.dart';

class CoorAndAddress{
  String? addressUpper;
  String? addressLower;
  NLatLng? coor;

  CoorAndAddress({
    this.addressUpper,
    this.addressLower,
    this.coor
  });

  CoorAndAddress.AddressFromJSON(String json){
    Map<String, dynamic> result = Map<String, dynamic>.from(List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["results"])[0])["region"];
    addressUpper = Map<String, dynamic>.from(result["area1"])["name"].toString() + ' ' + Map<String, dynamic>.from(result["area2"])["name"].toString();
    addressLower = Map<String, dynamic>.from(result["area3"])["name"].toString() + ' ' + Map<String, dynamic>.from(result["area4"])["name"].toString();
  }

  CoorAndAddress.CoordinateFromJSON(String json){
    Map<String, dynamic> result = Map<String, dynamic>.from(List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["addresses"])[0]);
    coor = NLatLng(double.parse(result["y"]), double.parse(result["x"]));
  }
}

Future<CoorAndAddress> GETCoorToAddJSON(NLatLng coor) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=${coor.longitude},${coor.latitude}&output=json'),
      headers: {
        "X-NCP-APIGW-API-KEY-ID" : naverMapKeyID,
        "X-NCP-APIGW-API-KEY" : naverMapKey
      }
    );

    print(utf8.decode(response.bodyBytes));

    switch (response.statusCode) {
      case 200:
        return CoorAndAddress.AddressFromJSON(utf8.decode(response.bodyBytes));
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

  return CoorAndAddress(addressUpper: " ", addressLower: " ");
}

Future<CoorAndAddress> GETAddToCoorJSON(String address) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query=${address}'),
      headers: {
        "X-NCP-APIGW-API-KEY-ID" : naverMapKeyID,
        "X-NCP-APIGW-API-KEY" : naverMapKey
      }
    );

    switch (response.statusCode) {
      case 200:
        return CoorAndAddress.CoordinateFromJSON(utf8.decode(response.bodyBytes));
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

  return CoorAndAddress(addressUpper: " ", addressLower: " ");
}

