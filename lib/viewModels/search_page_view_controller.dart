import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchPageViewController extends GetxController{

  //////////////////////////////////////////////////////////////////////////////search page

  TextEditingController searchWordTextEditController = TextEditingController();

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

  //spot lists
  RxList<Spot> spotList = <Spot>[].obs;

  void updateSpotList(List<Spot> newSpotList){
    spotList(newSpotList);
  }

  Future<bool> searchSpots() async {
    List<Spot> newSpotList = await GETSpotList(
        searchWord: searchWordTextEditController.text,
        categoryInd: categoryInd.value,
        keyWordIndList: keyWordIndList,
        coor: Get.find<UserController>().curPosition.value,
    );
    if(Spot.ifErrorList(newSpotList)){
      return false;
    }
    else{
      updateSpotList(newSpotList);
      return true;
    }
  }

  //////////////////////////////////////////////////////////////////////////////search map page

  //map
  late NaverMapController mapController;
  RxList<NMarker> markers = <NMarker>[].obs;

  void updateMarker(BuildContext context){
    // OverlayImage.fromAssetImage(assetName: "assets/images/marker.png", context: context).then((image) =>
    //     markers(spotList().map((e) => Marker(
    //         markerId: e.placeId,
    //         position: e.coor,
    //         icon: image,
    //         height: 40,
    //         width: 40,
    //         onMarkerTab: (marker, map){
    //           updateCurCamPostion(marker.position);
    //         }
    //     )).toList()
    //     )
    // );
    // markers.refresh();
  }

  void onMapReady(NaverMapController controller) {
    mapController = controller;
  }

  void updateCurCamPostion(NLatLng position){
    mapController.updateCamera(NCameraUpdate.fromCameraPosition(NCameraPosition(target: position, zoom: 15)));
  }

  //drawer
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


  //orderButton
  RxInt orderButtonIndex = 0.obs;
  RxBool orderIfDescending = false.obs;

  void increaseOrderIndex(){
    orderButtonIndex((orderButtonIndex.value + 1) % sortBy.length);
    sortSpotList();
  }

  void changeDescending(){
    orderIfDescending.value ? orderIfDescending(false) : orderIfDescending(true);
    sortSpotList();
  }

  void sortSpotList(){
    spotList.sort((a, b){
      switch(orderButtonIndex.value){
        case 0:
          return orderIfDescending.value ? a.distance - b.distance : b.distance - a.distance;
        case 1:
          return orderIfDescending.value ? a.spotNum - b.spotNum : b.spotNum - a.spotNum;
        default:
          return 0;
      }
    });
  }

  //Review List
  RxList<Review> reviewList = <Review>[].obs;

  void updateReviewList(List<Review> newReviewList){
    reviewList(newReviewList);
  }

  Future<bool> searchReview(String placeId) async{
    List<Review> newReviewList = await GETReviewList(placeId: placeId);
    if(newReviewList.isEmpty) {
      return false;
    } else {
      updateReviewList(newReviewList);
      return true;
    }
  }
}