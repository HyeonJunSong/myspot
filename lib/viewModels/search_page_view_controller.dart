import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class SearchPageViewController extends GetxController{

  //////////////////////////////////////////////////////////////////////////////search page

  TextEditingController searchWordTextEditController = TextEditingController();

  //category & keyword
  RxList<CategorySelect> categorySelectList = List<CategorySelect>.from(categoryList.map((e) => CategorySelect(false, e))).obs;
  RxList<KeyWordSelect> keyWordSelectList = List<KeyWordSelect>.from(keyWordList.map((e) => KeyWordSelect(false, e))).obs;

  int curCategoryInd = -1;

  void categoryChange(CategorySelect element){

    int ind = categorySelectList.indexOf(element);

    if(curCategoryInd == -1){
      categorySelectList[ind].ifActivated = true;
      curCategoryInd = ind;
    }
    else{

      if(categorySelectList[ind].ifActivated == true){
        categorySelectList[ind].ifActivated = false;
        curCategoryInd = -1;
      }
      else{
        categorySelectList[curCategoryInd].ifActivated = false;
        categorySelectList[ind].ifActivated = true;
        curCategoryInd = ind;
      }
    }
    categorySelectList.refresh();
  }

  void keyWordChange(KeyWordSelect element){
    int ind = keyWordSelectList.indexOf(element);
    if(keyWordSelectList[ind].ifActivated) {
      keyWordSelectList[ind].ifActivated = false;
    } else {
      keyWordSelectList[ind].ifActivated = true;
    }
    keyWordSelectList.refresh();
  }

  void searchSpots() async {
    updateSpotList(await GETSpotList(
      searchWord: searchWordTextEditController.text,
      category: categorySelectList,
      keyWord: keyWordSelectList,
      coor: Get.find<UserController>().curPosition.value,
    ));
  }

  //////////////////////////////////////////////////////////////////////////////search map page

  //map
  late NaverMapController mapController;
  RxList<Marker> markers = <Marker>[].obs;

  void updateMarker(BuildContext context){
    OverlayImage.fromAssetImage(assetName: "assets/images/marker.png", context: context).then((image) =>
        markers(spotList().map((e) => Marker(
            markerId: e.placeId,
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

  //spot lists
  RxList<Spot> spotList = <Spot>[
    Spot(
      placeName: "스타벅스 경북대북문점",
      address: "산격동 1399-2",
      spotNum: 1325,
      coor: LatLng(35.89229637317734, 128.60856585746507),
      placeId: "0",
    ),
    Spot(
      placeName: "이디야커피 경북대북문점",
      address: "산격동 1399-1",
      spotNum: 756,
      coor: LatLng(35.8929148936863, 128.608742276315),
      placeId: "2",
    ),
    Spot(
        placeName: "커피와빵 경북대북문점",
        address: "산격동 1331-6",
        spotNum: 220,
        coor: LatLng(35.8937633273376, 128.609716301503),
        placeId: "3"
    ),
    Spot(
      placeName: "스타벅스 경북대북문점",
      address: "산격동 1399-2",
      spotNum: 1325,
      coor: LatLng(35.89229637317734, 128.60856585746507),
      placeId: "4",
    ),
    Spot(
      placeName: "이디야커피 경북대북문점",
      address: "산격동 1399-1",
      spotNum: 756,
      coor: LatLng(35.8929148936863, 128.608742276315),
      placeId: "5",
    ),
    Spot(
        placeName: "커피와빵 경북대북문점",
        address: "산격동 1331-6",
        spotNum: 220,
        coor: LatLng(35.8937633273376, 128.609716301503),
        placeId: "6"
    ),
  ].obs;

  void updateSpotList(List<Spot> newSpotList){
    spotList(newSpotList);
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