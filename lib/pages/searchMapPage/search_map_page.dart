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
          _drawer(context)
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
                    _searchBoxAndTags(context),
                    Divider(thickness: 1.h,),
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
                  child: categoryBlock(
                      Get.find<SearchPageViewController>().categoryInd.value == categoryList.indexOf(category),
                      category.emoji,
                      category.categoryName
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
                  child: keyWordBlock(
                      Get.find<SearchPageViewController>().keyWordIndList.contains(keyWordList[Get.find<SearchPageViewController>().categoryInd.value].indexOf(keyWord)),
                      keyWord.emoji,
                      keyWord.keyWordName
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

  _resultBlock(Spot spot) => GestureDetector(
    onTap: () async{
      if(await Get.find<SearchPageViewController>().searchReview(spot.placeId)){
        Get.toNamed(
            '/SpotDetail',
            arguments: spot
        );
      }
    },
    child: Container(
      width: 390.w,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFFE5E5E5),
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(spot.placeName, style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16.sp
          ),),
          SizedBox(height: 6.h,),
          Row(
            children: [
              Text('${spot.distance}m', style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737373),
                  fontSize: 14.sp
              ),),
              Container(
                width: 1.w,
                height : 20.h,
                margin: EdgeInsets.symmetric(horizontal: 8.w),
                color: const Color(0xFFBDBDBD),
              ),
              Text(spot.address, style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF737373),
                  fontSize: 14.sp
              ),),
            ],
          ),
          SizedBox(height: 6.h,),
          Row(
            children: [
              Icon(Icons.circle, color: _spotColor(spot.spotNum), size: 11.w,),
              SizedBox(width: 10.w,),
              Text(NumberFormat("###,###,###").format(spot.spotNum), style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: _spotColor(spot.spotNum),
                  fontSize: 14.sp
              ),),
            ],
          ),
        ],
      ),
    ),
  );

  _spotColor(int likes){
    if(likes > 1000) return const Color(0xFFEA5252);
    if(likes >  500) return const Color(0xFF2BAE5F);
    if(likes >    0) return const Color(0xFF0789E8);
  }

}

