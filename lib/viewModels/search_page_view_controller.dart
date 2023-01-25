import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/spot_list_element.dart';

class SearchPageViewController extends GetxController{
  //drawer
  RxDouble drawer_topSpace = 471.h.obs;

  void updateDrawerTopSpace(double newVal){
    drawer_topSpace(newVal);
  }

  //category & keyword
  RxList<CategorySelect> categorySelectList = List<CategorySelect>.from(categoryList.map((e) => CategorySelect(false, e))).obs;
  RxList<KeyWordSelect> keyWordSelectList = List<KeyWordSelect>.from(keyWordList.map((e) => KeyWordSelect(false, e))).obs;

  void categoryChange(CategorySelect element){
    int ind = categorySelectList.indexOf(element);
    if(categorySelectList[ind].ifActivated) {
      categorySelectList[ind].ifActivated = false;
    } else {
      categorySelectList[ind].ifActivated = true;
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
          return orderIfDescending.value ? a.likes - b.likes : b.likes - a.likes;
        default:
          return 0;
      }
    });
  }

  //spot lists
  RxList<Spot> spotList = <Spot>[
    Spot("스타벅스 경북대북문점", 220, "산격동 1399-2", 1325),
    Spot("이디야커피 경북대북문점", 220, "산격동 1399-1", 756),
    Spot("커피와빵 경북대북문점", 220, "산격동 1331-6", 233),
    Spot("스타벅스 경북대북문점", 220, "산격동 1399-2", 1325),
    Spot("이디야커피 경북대북문점", 220, "산격동 1399-1", 756),
    Spot("커피와빵 경북대북문점", 220, "산격동 1331-6", 233),
  ].obs;

}

class CategorySelect{
  bool ifActivated;
  Category category;

  CategorySelect(this.ifActivated, this.category);
}

class KeyWordSelect{
  bool ifActivated;
  KeyWord keyWord;

  KeyWordSelect(this.ifActivated, this.keyWord);
}

List<String> sortBy = [
  "거리 순",
  "스팟 순"
];