
import 'package:get/get.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/viewModels/user_controller.dart';

class MyPageViewController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getMyReviewAndSpotList();
  }

  RxBool mySpotToggle = false.obs;
  void toggleMySpot(){
    mySpotToggle(!mySpotToggle.value);
  }

  RxBool myReviewToggle = false.obs;
  void toggleMyReview(){
    myReviewToggle(!myReviewToggle.value);
  }

  //Review List
  RxList<Review> myReviewList = <Review>[].obs;

  void updateReviewList(List<Review> newReviewList){
    myReviewList(newReviewList);
  }

  //spot lists
  RxList<Spot> mySpotList = <Spot>[].obs;

  void updateSpotList(List<Spot> newSpotList){
    mySpotList(newSpotList);
  }

  //get review and spot list
  void getMyReviewAndSpotList() async {
    var result = await User.GETUserSpotReview(Get.find<UserController>().email);
    updateSpotList(result.$1);
    updateReviewList(result.$2);
  }

}