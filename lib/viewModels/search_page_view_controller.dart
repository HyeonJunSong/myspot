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

  //spot lists
  RxList<SpotListElement> spotList = <SpotListElement>[
    SpotListElement("스타벅스 경북대북문점", 220, "산격동 1399-2", 1325),
    SpotListElement("이디야커피 경북대북문점", 220, "산격동 1399-1", 756),
    SpotListElement("커피와빵 경북대북문점", 220, "산격동 1331-6", 233),
    SpotListElement("스타벅스 경북대북문점", 220, "산격동 1399-2", 1325),
    SpotListElement("이디야커피 경북대북문점", 220, "산격동 1399-1", 756),
    SpotListElement("커피와빵 경북대북문점", 220, "산격동 1331-6", 233),
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