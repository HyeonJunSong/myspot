import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/services/api.dart';
import 'package:myspot/viewModels/city_view_controller.dart';
import 'package:myspot/widgets/drop_down_set_location_city.dart';

class LocationList {
  List<String> name;
  List<String> code;

  LocationList(this.name, this.code);

  LocationList.fromJson(Map<String, dynamic> json)
      : name = json['locationName'].cast<String>(),
        code = json['locationCode'].cast<String>();

  Map<String, dynamic> toJson() =>
      {
        'locationName': name,
        'locationCode': code,
      };
}

String _baseUrl = "http://34.249.122.42:8080/";

Future<LocationList> GETLocationJSON(String query) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('${_baseUrl}${query}'),
    );

    switch (response.statusCode) {
      case 200:
        return LocationList.fromJson(json.decode(utf8.decode(response.bodyBytes)));
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
  return LocationList([""], [""]);
}

LocationList locations_city = LocationList(["선택없음"], ["00"]);
LocationList locations_gu = LocationList(["선택없음"], ["00"]);
LocationList locations_dong = LocationList(["선택없음"], ["00"]);

void updateCity() async{
  LocationList response = await GETLocationJSON("location/city");
  locations_city.name = response.name;
  locations_city.code = response.code;

  Get.find<CityViewController>().updateCity(response.name);
}

void updateGu(String code) async{
  LocationList response = await GETLocationJSON("location/gu?code=${code}");
  locations_gu.name = response.name;
  locations_gu.code = response.code;

  Get.find<CityViewController>().updateGu(response.name);
}

void updateDong(String code) async{
  LocationList response = await GETLocationJSON("location/dong?code=${code}");
  locations_dong.name = response.name;
  locations_dong.code = response.code;

  Get.find<CityViewController>().updateDong(response.name);
}
