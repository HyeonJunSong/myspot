import 'package:get/get.dart';

class CityViewController extends GetxController{
  RxMap<String, Map<String, List<String>>> cityList = {"선택없음": {"선택없음" : ["선택없음"]}}.obs;

  RxString city  = "선택없음".obs;
  RxString gu  = "선택없음".obs;
  RxString dong  = "선택없음".obs;

  void updateCityList(Map<String, Map<String, List<String>>> newCityList){
    cityList(newCityList);
  }

  void updateCity(String newValue){
    city(newValue);
    gu("선택없음");
    dong("선택없음");
  }

  void updateGu(String newValue){
    gu(newValue);
    dong("선택없음");
  }

  void updateDong(String newValue){
    dong(newValue);
  }
}