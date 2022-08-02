import 'package:get/get.dart';

class CityViewController extends GetxController{
  RxList<String> city = ["선택없음"].obs;
  RxList<String> gu = ["선택없음"].obs;
  RxList<String> dong = ["선택없음"].obs;

  void updateCity(List<String> newCity){
    city(newCity);
  }

  void updateGu(List<String> newGu){
    gu(newGu);
  }

  void updateDong(List<String> newDong){
    dong(newDong);
  }
}