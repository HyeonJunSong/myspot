
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:myspot/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/utils/keyFiles.dart';

import "package:http_parser/http_parser.dart";

class Review {
  //사용자 관련
  String user_email;

  //스팟 관련
  String placeId;
  String address;
  String locationLongtitude;
  String locationLatitude;
  String placeName;

  String category;  //카테고리
  String comment;   //한줄평
  String spotFolder;    //폴더
  List<String> spotTag; //키워드
  String reviewedDate;  //리뷰 작성일
  List<String> photo;

  Review({
    this.user_email = "",
    this.placeId = "",
    this.address = "",
    this.locationLongtitude = "",
    this.locationLatitude = "",
    this.placeName = "",
    this.category = "",
    this.comment = "",
    this.spotFolder = "none",
    this.spotTag = const [],
    this.reviewedDate = "",
    this.photo = const [],
  });

  static List<Review> ReviewListFromJSON(String json){
    List<Review> newReviewList = [];
    List<dynamic>.from(Map<String, dynamic>.from(jsonDecode(json))["data"]).forEach((element) {
      print(element);
      newReviewList.add(
        Review(
          user_email: element["useremail"],
          placeId: element["location_num"].toString(),
          address: "",
          locationLongtitude: "",
          locationLatitude: "",
          placeName: element["spotName"],
          category: element["spotcategory"],
          comment: element["spotComment"],
          spotFolder: element["spotFolder"],
          spotTag: const [],
          reviewedDate: element["spotDate"] != null ? DateFormat("yyyy.MM.dd HH:mm").format(DateTime.parse(element["spotDate"])).toString() : "",
          photo: element["spotPhoto"][0] == "" ? [] : List<String>.from(element["spotPhoto"]),
        )
      );
    });
    return newReviewList;
  }
}

Future<bool> POSTnewReview(Review review) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl$spotPostUrl'));
    // var request = http.MultipartRequest('POST', Uri.http("3.232.20.72:8080", spotPostUrl));
    // request.headers.addAll({
    //   "Content-Type": "multipart/form-data"
    // });
    request.fields.addAll({
      "user_email": review.user_email,
      "locationMapCode": review.placeId,
      "locationAddress": review.address,
      "locationLongitude": review.locationLongtitude.toString(),
      "locationLatitude": review.locationLatitude.toString(),
      "locationName": review.placeName,
      "spotCategory": review.category,
      "spotComment": review.comment,
      "spotFolder": review.spotFolder,
      "spotTag" : review.spotTag.join(","),
    });

    if(review.photo.isNotEmpty) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'spotImg',
          review.photo[0],
          // contentType: MediaType('image', 'jpg'),
        )
      );
    }

    var response = await request.send();
    print(await response.stream.bytesToString());
    switch(response.statusCode){
      case 200:
        return true;
      default:
        return false;
    }

  } on SocketException {
    apiResponse.apiError = ApiError(error: "Server error. Please retry");
  }

  return false;
}

Future<List<Review>> GETReviewList(
  {
    required String placeId,
  }) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('$baseUrl$reviewSearchUrl?locationCode=$placeId'),
    );

    print("GETReviewList");
    print(utf8.decode(response.bodyBytes));
    switch (response.statusCode) {
      case 200:
        return Review.ReviewListFromJSON((utf8.decode(response.bodyBytes)));
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

  return <Review>[];
}