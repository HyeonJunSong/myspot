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
import 'package:flutter_naver_map/flutter_naver_map.dart';

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

  //Image Path list
  //나중에 review로 묶으셈
  List<String> imagePathList = <String>[].obs;

  void updateImagePathList(List<String> newImagePathList){
    imagePathList = newImagePathList;
  }

  //Comment
  String comment = "";
  void updateComment(String newComment){
    comment = newComment;
  }

  //Post
  Future<bool> post() async {
    print(Get.find<UserController>().email);
    return POSTnewReview(
      Review(
        user_email: Get.find<UserController>().email,
        placeId: location.value.id,
        address: location.value.address,
        locationLongtitude: location.value.coor.longitude.toString(),
        locationLatitude: location.value.coor.latitude.toString(),
        placeName: location.value.placeName,
        comment: comment,
        spotTag: [],
        photo: imagePathList,
      )
    );
  }

  ////PostMapPage

  //map
  late NaverMapController mapController;
  RxList<NMarker> markers = <NMarker>[].obs;

  Future<void> updateMarker(BuildContext context) async {

    final markerIcon = await NOverlayImage.fromAssetImage("assets/images/marker.png");

    mapController.addOverlayAll(
      Set<NMarker>.from(searchResult.map((e) {
        NMarker newMarker = NMarker(
          id: e.id,
          position: e.coor,
          icon: markerIcon,
          size: Size(40.w, 40.h),
        );

        newMarker.setOnTapListener((overlay) {
          setDrawerMid();
          updateCurCamPostion(NLatLng(e.coor.latitude - 0.0001, e.coor.longitude));
        });
        return newMarker;
      }))
    );

    // OverlayImage.fromAssetImage(assetName: "assets/images/marker.png", context: context).then((image) =>
    //     markers(searchResult().map((e) => Marker(
    //       markerId: e.id,
    //       position: e.coor,
    //       icon: image,
    //       height: 40,
    //       width: 40,
    //       onMarkerTab: (marker, map){
    //         updateCurCamPostion(marker.position);
    //       }
    //     )).toList()
    //   )
    // );
    // refresh();
  }

  void removeMarker(){
    mapController.clearOverlays();
  }

  void onMapReady(NaverMapController controller) {
    mapController = controller;
  }

  void updateCurCamPostion(NLatLng position){
    mapController.updateCamera(NCameraUpdate.fromCameraPosition((NCameraPosition(target: position, zoom: 18))));
  }

  ////LocationSearchResult
  RxString searchKeyword = "".obs;
  RxList<LocationSearchResult> searchResult = <LocationSearchResult>[].obs;

  void updateSearchKeyword(String newKeyword){
    searchKeyword(newKeyword);
  }

  void updateSearchResult(List<LocationSearchResult> result, BuildContext context){
    searchResult(result);
    removeMarker();
    updateMarker(context);
  }

  void keyWordSearch(BuildContext context) async {
    if(searchKeyword.isEmpty) return;

    NCameraPosition curCamPos = await mapController.getCameraPosition();
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
