import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/services/api.dart';
import 'package:myspot/services/distance_calculate.dart';
import 'package:myspot/utils/keyFiles.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class Spot{
  String place; // locationname
  late int distance;
  String address; // locationAddress
  int likes; // location_num
  LatLng coor; // locationLatitude, locationLongitude
  String id; // locationmapcode

  Spot({
    required this.place,
    required this.address,
    required this.likes,
    required this.coor,
    required this.id
  }){
    distance = distanceInMBetweenEarthCoordinates(Get.find<UserController>().curPosition.value, coor);
  }

  Spot.nullInit({
    this.place = "",
    this.distance = 0,
    this.address = "",
    this.likes = 0,
    this.coor = const LatLng(0, 0),
    this.id = ""
  });

  static List<Spot> SpotListFromJSON(String json){
    List<Spot> newSpotList = [];
    List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["data"]).forEach((element) {
      newSpotList.add(
        Spot(
          place: element["locationName"],
          address: element["locationAddress"],
          likes: int.parse(element["spotCount"]),
          coor: LatLng(double.parse(element["locationLatitude"]), double.parse(element["locationLongitude"])),
          id: element["locationCode"]
        )
      );
    });
    return newSpotList;
  }
}

Future<List<Spot>> GETSpotList({
  required String searchWord,
  required List<CategorySelect> category,
  required List<KeyWordSelect> keyWord,
  required LatLng coor
}) async {
  ApiResponse apiResponse = ApiResponse();

  String _category = "";
  category
    .forEach((element) {
      _category += element.category.categoryName;
      if(element != category.last)
        _category += ",";
    });
  print(_category);

  String _keyWord = "";
  keyWord
    .forEach((element) {
    _keyWord += element.keyWord.keyWordName;
      if(element != keyWord.last)
        _keyWord += ",";
    });
  print(_keyWord);

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

  return <Spot>[];
}