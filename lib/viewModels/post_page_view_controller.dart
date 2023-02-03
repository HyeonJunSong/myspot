import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/spot_list_element.dart';
import 'package:myspot/services/coor_address_transition.dart';
import 'package:myspot/services/keyword_location_search.dart';
import 'package:myspot/utils/constants.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class PostPageViewController extends GetxController{
  //map
  late NaverMapController mapController;

  void onMapCreated(NaverMapController controller) {
    mapController = controller;
  }

  void updateCurCamPostion(LatLng position){
    mapController.moveCamera(CameraUpdate.toCameraPosition(CameraPosition(target: position)));
  }

  //LocationSearchResult
  RxString searchKeyword = "".obs;
  RxList<LocationSearchResult> searchResult = <LocationSearchResult>[].obs;

  void updateSearchKeyword(String newKeyword){
    searchKeyword(newKeyword);
  }

  void updateSearchResult(List<LocationSearchResult> result){
    searchResult(result);
  }

  void keyWordSearch() async {
    if(searchKeyword.isEmpty) return;

    CameraPosition curCamPos = await mapController.getCameraPosition();
    List<LocationSearchResult> result = await GETKeywordLocationSearchJSON(searchKeyword.value, curCamPos.target);
    updateSearchResult(result);
  }

  //drawer
  RxDouble drawer_topSpace = 471.h.obs;

  void updateDrawerTopSpace(double newVal) {
    drawer_topSpace(newVal);
  }
  void calibrateDrawerTopSpace(){
    if((drawer_topSpace.value - drawer_bottom.h).abs() < (drawer_topSpace.value - drawer_mid.h).abs())
      drawer_topSpace(drawer_bottom.h);
    else
      if ((drawer_topSpace.value - drawer_mid.h).abs() < (drawer_topSpace.value - drawer_top.h).abs())
        drawer_topSpace(drawer_mid.h);
      else
        drawer_topSpace(drawer_top.h);
  }
}