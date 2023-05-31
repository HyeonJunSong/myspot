
import 'package:get/get.dart';

class MyPageViewController extends GetxController{

  RxBool mySpotToggle = false.obs;
  void toggleMySpot(){
    mySpotToggle(!mySpotToggle.value);
  }

}