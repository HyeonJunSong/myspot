import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/category_keyword_block.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:myspot/widgets/list_element_spot.dart';


class SearchMapPage extends StatelessWidget {
  const SearchMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.find<SearchPageViewController>().searchSpots();
    return Obx( () => Scaffold(
      extendBodyBehindAppBar: true,
      appBar: searchMapPageAppbar(),
      resizeToAvoidBottomInset : false,
      body: Stack(
        children: [
          _map(),
          _drawer(context),
          _categoryAndKeywordRow(),
        ],
      ),
    ));
  }

  _map() => Positioned(
    child: NaverMap(
      onMapReady: Get.find<SearchPageViewController>().onMapReady,
      options: NaverMapViewOptions(
        mapType: NMapType.basic,
        initialCameraPosition: NCameraPosition(
          target: Get.find<UserController>().curPosition.value,
          zoom: 16,
        ),
      ),
    ),
  );

  _categoryAndKeywordRow() => Positioned(
    top: 110.h,
    child: Container(
      width: 390.w,
      color: Colors.transparent,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Get.find<SearchPageViewController>().categoryInd.value != -1 ?
        Row(
          children: <Widget>[
            SizedBox(width: 20.w,),
            CategoryBlock.fromCategoryIndActivated(Get.find<SearchPageViewController>().categoryInd.value),
          ]
          + List.generate(
            Get.find<SearchPageViewController>().keyWordIndList.length,
            (index) => KeyWordBlock.fromKeyWordIndActivated(Get.find<SearchPageViewController>().keyWordIndList[index]),
          )
        ): Container(),
      ),
    ),
  );

  _drawer(BuildContext context) => AnimatedPositioned(
    curve: Curves.easeOut,
    duration: const Duration(milliseconds: 100),
    top: Get.find<SearchPageViewController>().drawer_topSpace.value,
    child: Container(
      width: 390.w,
      height: 900.h,
      padding: EdgeInsets.only(top: 10.h),
      decoration: const BoxDecoration(
        color: colorWhite
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _knob(),
          Container(
            height: 844.h,
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    // _searchBoxAndTags(context),
                    // Divider(thickness: 1.h,),
                    _searchResultList(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  _knob() => GestureDetector(
    onVerticalDragUpdate: (value){
      if(value.globalPosition.dy >= 65.h)
        Get.find<SearchPageViewController>().updateDrawerTopSpace(value.globalPosition.dy);
      else
        Get.find<SearchPageViewController>().updateDrawerTopSpace(65.h);
    },
    onVerticalDragEnd: (value){
      Get.find<SearchPageViewController>().calibrateDrawerTopSpace();
    },
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10.h),
      child: Container(
        width: 50.w,
        height: 7.h,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        color: Colors.grey,
      ),
    ),
  );

  //////////////////////////////////////////////////////////////////////////////searchBox and Tags
  _searchBoxAndTags(BuildContext context) => Container(
    padding: EdgeInsets.fromLTRB(21.w, 16.h, 21.w, 23.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchBox(context),
        SizedBox(height: 23.h,),
        _categoryBox(),
        _keyWordBox(),
      ],
    ),
  );

  _searchBox(BuildContext context) => Container(
    width: 317.w,
    height: 48.h,
    child: _inputBox(context),
  );

  _inputBox(BuildContext context) => Container(
    width: 317.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: const Color(0xFFFBFBFB),
    ),
    padding: EdgeInsets.fromLTRB(23.w, 0, 17.w, 0),
    child: Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 48.h,
          width: 260.w,
          child: TextField(
            decoration: const InputDecoration(
              isDense: true,
              hintText: "가게명, 메뉴 검색",
              hintStyle: TextStyle(
                color: colorInactive,
                fontWeight: FontWeight.w500,
              ),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
              contentPadding: EdgeInsets.all(0),
            ),
            style: TextStyle(
              color: colorInactive,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            textAlignVertical: TextAlignVertical.center,
            cursorColor: colorInactive,
            controller: Get.find<SearchPageViewController>().searchWordTextEditController,
            onSubmitted: (value){
              Get.find<SearchPageViewController>().searchSpots();
            },
          ),
        ),
        GestureDetector(
          child: Image.asset("assets/images/search.png", width: 14.w, height: 14.h, color: colorInactive,),
          onTap: (){
            Get.find<SearchPageViewController>().searchSpots();
          },
        )
      ],
    ),
  );

  _categoryBox() => Container(
    width: 310.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("카테고리 선택", style: TextStyle(
          color: colorBlack,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),),
        SizedBox(height: 16.sp,),
        Wrap(
            children: List<Widget>.from(categoryList.map((category) =>
                GestureDetector(
                  child: CategoryBlock(
                    ifActivated: Get.find<SearchPageViewController>().categoryInd.value == categoryList.indexOf(category),
                    emoji: category.emoji,
                    categoryName: category.categoryName,
                  ),
                  onTapUp: (value){
                    Get.find<SearchPageViewController>().categoryChange(categoryList.indexOf(category));
                  },
                ),
            )
            )),
      ],
    ),
  );

  _keyWordBox() => Container(
    width: 310.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("키워드 선택", style: TextStyle(
          color: colorBlack,
          fontSize: 16.sp,
          fontWeight: FontWeight.w700,
        ),),
        SizedBox(height: 16.sp,),
        Get.find<SearchPageViewController>().categoryInd.value == -1 ? Container() : Wrap(
            children: List<Widget>.from(keyWordList[Get.find<SearchPageViewController>().categoryInd.value].map((keyWord) =>
                GestureDetector(
                  child: KeyWordBlock(
                      ifActivated: Get.find<SearchPageViewController>().keyWordIndList.contains(keyWordList[Get.find<SearchPageViewController>().categoryInd.value].indexOf(keyWord)),
                      emoji: keyWord.emoji,
                      keyWordName: keyWord.keyWordName
                  ),
                  onTapUp: (value){
                    Get.find<SearchPageViewController>().keyWordChange(keyWordList[Get.find<SearchPageViewController>().categoryInd.value].indexOf(keyWord));
                  },
                ),
            ))
        ),
      ],
    ),
  );

  _searchResultList() => Container(
    child: Column(
      children: <Widget>[
        _orderBolck(),
      ]
      + List<Widget>.from(Get.find<SearchPageViewController>().spotList.map(
        (element) => listElementSpot(element)
      ).toList())
      + [
        SizedBox(
          height: Get.find<SearchPageViewController>().drawer_topSpace.value + 900.h - 844.h - 20.h,
        ),
      ],
    ),
  );

  _orderBolck() => Container(
    padding: EdgeInsets.fromLTRB(18.w, 28.h, 18.w, 21.h),
    child: Row(
      children: [
        GestureDetector(
          onTap: (){
            Get.find<SearchPageViewController>().increaseOrderIndex();
          },
          child: Container(
            width: 129.w,
            height: 33.h,
            padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: colorInactive,
                width: 2.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20.r)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(sortBy[Get.find<SearchPageViewController>().orderButtonIndex.value]),
                GestureDetector(
                  child: Icon(
                    Get.find<SearchPageViewController>().orderIfDescending.value ?
                    Icons.keyboard_arrow_up :
                    Icons.keyboard_arrow_down
                  ),
                  onTap: (){
                    Get.find<SearchPageViewController>().changeDescending();
                  },
                )
              ],
            )
          ),
        ),
      ],
    ),
  );
}

