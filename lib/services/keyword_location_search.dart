import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myspot/utils/keyFiles.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

import 'api.dart';

class LocationSearchResult{
  LatLng coor;
  String placeName;
  String address;
  String id;

  LocationSearchResult({
    required this.coor,
    required this.placeName,
    required this.address,
    required this.id
  });

  LocationSearchResult.nullInit()
      : this.coor = LatLng(0, 0),
        this.placeName = "",
        this.address = "",
        this.id = ""
  ;

  static List<LocationSearchResult> locationListFromJson(String json) {
    List<LocationSearchResult> result = [];
    List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["documents"]).forEach((element) {
      Map<String, dynamic> e = Map<String, dynamic>.from(element);
      result.add(
        LocationSearchResult(
          coor: LatLng(double.parse(e["y"]), double.parse(e["x"])),
          placeName: e["place_name"],
          address: e["road_address_name"],
          id: e["id"]
        )
      );
    });

    return result;
  }
}

Future<List<LocationSearchResult>> GETKeywordLocationSearchJSON(String keyword, LatLng coor) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
        Uri.parse('https://dapi.kakao.com/v2/local/search/keyword.json?query=${keyword}&x=${coor.longitude}&y=${coor.latitude}'),
        headers: {
          "Authorization" : "KakaoAK ${kakaoAPIKey}",
        }
    );

    switch (response.statusCode) {
      case 200:
        print(utf8.decode(response.bodyBytes));
        return LocationSearchResult.locationListFromJson(utf8.decode(response.bodyBytes));
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

  return <LocationSearchResult>[];
}