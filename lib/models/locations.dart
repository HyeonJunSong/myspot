import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:myspot/services/api.dart';
import 'package:myspot/viewModels/city_view_controller.dart';
import 'package:myspot/widgets/drop_down_set_location_city.dart';

class cityLists {
//  Map<String, Map<String, List<String>>> cityList;
  Map<String, Map<String, List<String>>> cityList = Map<String, Map<String, List<String>>>();

  cityLists(this.cityList);

  cityLists.fromJson(String json){
    Map<String, dynamic> jsonCity = Map<String, dynamic>.from(jsonDecode(json));

    cityList["선택없음"] = Map<String, List<String>>();
    cityList["선택없음"]!["선택없음"] = ["선택없음"];
    jsonCity.forEach((keyCity, valueCity) {
      Map<String, dynamic> jsonGu = Map<String, dynamic>.from(valueCity);
      cityList[keyCity] = Map<String, List<String>>();
      cityList[keyCity]!["선택없음"] = ["선택없음"];
      jsonGu.forEach((keyGu, valueGu) {
        cityList[keyCity]![keyGu] = ["선택없음"] + List<String>.from(valueGu);
      });
    });
  }
  // : cityList = Map<String, Map<String, List<String>>>.from(jsonDecode(json));

  // Map<String, dynamic> toJson() =>
  //     {
  //       'locationName': name,
  //       'locationCode': code,
  //     };
}

String _baseUrl = "http://34.249.122.42:8080/";

Future<cityLists> GETLocationJSON(String query) async {
  ApiResponse apiResponse = ApiResponse();

  try {
    final response = await http.get(
      Uri.parse('${_baseUrl}${query}'),
    );

    switch (response.statusCode) {
      case 200:
       return cityLists.fromJson(utf8.decode(response.bodyBytes));
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
  return cityLists(Map<String, Map<String, List<String>>>());
}

void getCityList() async{
  cityLists response = await GETLocationJSON("location/citylist");
  Get.find<CityViewController>().updateCityList(response.cityList);
//  print(response.cityList["울산광역시"].runtimeType);
}