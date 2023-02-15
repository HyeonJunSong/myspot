import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/services/coor_address_transition.dart';
import 'package:myspot/services/keyword_location_search.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class PostPageViewController extends GetxController{

  ////PostPage

  Rx<LocationSearchResult> location = LocationSearchResult().obs;

  void updateLocation(LocationSearchResult location){
    this.location(location);
  }

  //category & keyword
  RxInt categoryInd = (-1).obs;
  RxList<int> keyWordIndList = <int>[].obs;

  void categoryChange(int newCategory){
    if(newCategory == categoryInd.value){
      categoryInd(-1);
    }
    else{
      categoryInd(newCategory);
    }
    keyWordIndList(<int>[]);
  }

  void keyWordChange(int newKeyWord){
    if(keyWordIndList.contains(newKeyWord)){
      keyWordIndList.remove(newKeyWord);
    }
    else{
      keyWordIndList.add(newKeyWord);
    }
    keyWordIndList.refresh();
  }

  //Post
  Future<bool> post() async {
    return POSTnewReview(
      Review(
        user_email: Get.find<UserController>().email,
        placeId: location.value.id,
        address: location.value.address,
        locationLongtitude: location.value.coor.longitude.toString(),
        locationLatitude: location.value.coor.latitude.toString(),
        placeName: location.value.placeName,
        comment: "",
        spotTag: [],
      )
    );
  }

  ////PostMapPage

  //map
  late NaverMapController mapController;
  RxList<Marker> markers = <Marker>[].obs;

  void updateMarker(BuildContext context){
    OverlayImage.fromAssetImage(assetName: "assets/images/marker.png", context: context).then((image) =>
        markers(searchResult().map((e) => Marker(
          markerId: e.id,
          position: e.coor,
          icon: image,
          height: 40,
          width: 40,
          onMarkerTab: (marker, map){
            updateCurCamPostion(marker.position);
          }
        )).toList()
      )
    );
    refresh();
  }

  void onMapCreated(NaverMapController controller) {
    mapController = controller;
  }

  void updateCurCamPostion(LatLng position){
    mapController.moveCamera(CameraUpdate.toCameraPosition(CameraPosition(target: position)));
  }

  ////LocationSearchResult
  RxString searchKeyword = "".obs;
  RxList<LocationSearchResult> searchResult = <LocationSearchResult>[].obs;

  void updateSearchKeyword(String newKeyword){
    searchKeyword(newKeyword);
  }

  void updateSearchResult(List<LocationSearchResult> result, BuildContext context){
    searchResult(result);
    updateMarker(context);
  }

  void keyWordSearch(BuildContext context) async {
    if(searchKeyword.isEmpty) return;

    CameraPosition curCamPos = await mapController.getCameraPosition();
    List<LocationSearchResult> result = await GETKeywordLocationSearchJSON(searchKeyword.value, curCamPos.target);

    updateSearchResult(result, context);
    setDrawerMid();
  }

  ////drawer
  RxDouble drawer_topSpace = drawer_bottom.h.obs;

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
  void setDrawerTop(){
    drawer_topSpace(drawer_top.h);
  }
  void setDrawerMid(){
    drawer_topSpace(drawer_mid.h);
  }
  void setDrawerBottom(){
    drawer_topSpace(drawer_bottom.h);
  }
}
