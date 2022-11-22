import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchMapViewController extends GetxController{
  RxDouble drawer_topSpace = 471.h.obs;

  void updateDrawerTopSpace(double newVal){
    drawer_topSpace(newVal);
  }

}