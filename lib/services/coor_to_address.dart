import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myspot/utils/keyFiles.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

import 'api.dart';

class CoorToAdd{
  String addressUpper = "";
  String addressLower = "";

  CoorToAdd({
    required this.addressUpper,
    required this.addressLower
  });

  CoorToAdd.fromJSON(String json){
    Map<String, dynamic> result = Map<String, dynamic>.from(List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["results"])[0])["region"];
    addressUpper = Map<String, dynamic>.from(result["area1"])["name"].toString() + ' ' + Map<String, dynamic>.from(result["area2"])["name"].toString();
    addressLower = Map<String, dynamic>.from(result["area3"])["name"].toString() + ' ' + Map<String, dynamic>.from(result["area4"])["name"].toString();
  }
}

Future<CoorToAdd> GETCoorToAddJSON(LatLng coor) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('https://naveropenapi.apigw.ntruss.com/map-reversegeocode/v2/gc?coords=${coor.longitude},${coor.latitude}&output=json'),
      headers: {
        "X-NCP-APIGW-API-KEY-ID" : naverMapKeyID,
        "X-NCP-APIGW-API-KEY" : naverMapKey
      }
    );

    switch (response.statusCode) {
      case 200:
        return CoorToAdd.fromJSON(utf8.decode(response.bodyBytes));
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

  return CoorToAdd(addressUpper: " ", addressLower: " ");
}

