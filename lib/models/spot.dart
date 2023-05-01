import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/services/api.dart';
import 'package:myspot/services/distance_calculate.dart';
import 'package:myspot/utils/keyFiles.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class Spot{
  String placeName; // locationname
  late int distance;
  String address; // locationAddress
  int spotNum; // location_num
  NLatLng coor; // locationLatitude, locationLongitude
  String placeId; // locationmapcode

  Spot({
    this.placeName = "",
    this.address = "",
    this.spotNum = 0,
    this.coor = const NLatLng(0, 0),
    this.placeId = ""
  }){
    distance = distanceInMBetweenEarthCoordinates(Get.find<UserController>().curPosition.value, coor);
  }

  static Spot errorSpotInit(){
    return Spot();
  }

  static List<Spot> SpotListFromJSON(String json){
    List<Spot> newSpotList = [];
    List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["data"]).forEach((element) {
      newSpotList.add(
        Spot(
          placeName: element["locationName"],
          address: element["locationAddress"],
          spotNum: int.parse(element["spotCount"]),
          coor: NLatLng(double.parse(element["locationLatitude"]), double.parse(element["locationLongitude"])),
          placeId: element["locationCode"]
        )
      );
    });
    return newSpotList;
  }

  static List<Spot> errorSpotListInit(){
    return [Spot.errorSpotInit()];
  }

  static bool ifErrorList(List<Spot> spotList) {
    if (spotList.first.placeId.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }
}

Future<List<Spot>> GETSpotList({
  required String searchWord,
  required int categoryInd,
  required List<int> keyWordIndList,
  required NLatLng coor
}) async {
  ApiResponse apiResponse = ApiResponse();

  String _category = "";
  if(categoryInd != -1) {
    _category = categoryList[categoryInd].categoryName;
  }

  String _keyWord = "";
  if(categoryInd != -1) {
    keyWordIndList
        .forEach((keyWordInd) {
      _keyWord += keyWordList[categoryInd][keyWordInd].keyWordName;
      if (keyWordInd != keyWordIndList.last)
        _keyWord += ",";
    });
  }

  try {
    final response = await http.get(
        Uri.parse('$baseUrl$spotSearchUrl?searchWord=$searchWord&category=$_category&keyword=$_keyWord&lat=${coor.latitude}&lon=${coor.longitude}'),
    );

    print(utf8.decode(response.bodyBytes));
    switch (response.statusCode) {
      case 200:
        return Spot.SpotListFromJSON((utf8.decode(response.bodyBytes)));
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

  return Spot.errorSpotListInit();
}