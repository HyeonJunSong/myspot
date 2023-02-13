
import 'dart:convert';
import 'dart:io';

import 'package:myspot/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/utils/keyFiles.dart';

class Post {
  //사용자 관련
  String user_email;

  //스팟 관련
  String locationMapCode;
  String locationAddress;
  String locationLongtitude;
  String locationLatitude;
  String locationName;

  //카테고리
  String spotCategory;

  //한줄평
  String spotComment;

  //폴더
  String spotFolder;

  //키워드
  List<String> spotTag;

  Post({
    required this.user_email,
    required this.locationMapCode,
    required this.locationAddress,
    required this.locationLongtitude,
    required this.locationLatitude,
    required this.locationName,
    this.spotCategory = "",
    required this.spotComment,
    this.spotFolder = "none",
    required this.spotTag,
  });
}

class PostRespond {
  late String result;
  late int spotNumber;
  late String useremail;
  late int locationnum;
  late String spot_name;
  late String spot_category;
  late String spot_Comment;
  late String spot_Photo;
  late String spot_Folder;

  PostRespond.fromJson(String json){
    Map<String, dynamic> respond = Map<String, dynamic>.from(jsonDecode(json));
    result = respond["result"];
    Map<String, dynamic> message = Map<String, dynamic>.from(
        respond["message"]);
    spotNumber = message["spotNumber"];
    useremail = message["useremail"];
    locationnum = message["locationnum"];
    spot_name = message["spot_name"];
    spot_category = message["spot_category"];
    spot_Comment = message["spot_Comment"];
    spot_Photo = message["spot_Photo"];
    spot_Folder = message["spot_Folder"];
  }

  PostRespond({
    this.result = "null",
    this.spotNumber = -1,
    this.useremail = "",
    this.locationnum = -1,
    this.spot_name = "",
    this.spot_category = "",
    this.spot_Comment = "",
    this.spot_Photo = "",
    this.spot_Folder = ""
  });
}

Future<PostRespond> POSTnewSpotPost(Post post) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.post(
      Uri.parse('${baseUrl}${spotPostUrl}'),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "user_email" : post.user_email,
        "locationMapCode" : post.locationMapCode,
        "locationAddress" : post.locationAddress,
        "locationLongtitude" : post.locationLongtitude,
        "locationLatitude" : post.locationLatitude,
        "locationName" : post.locationName,
        "spotCategory" : post.spotCategory,
        "spotComment" : post.spotComment,
        "spotFolder" : post.spotFolder,
        "spotTag" : post.spotTag,
      })
    );

    print(utf8.decode(response.bodyBytes));
    switch (response.statusCode) {
      case 200:
        return PostRespond.fromJson((utf8.decode(response.bodyBytes)));
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

  return PostRespond();
}
