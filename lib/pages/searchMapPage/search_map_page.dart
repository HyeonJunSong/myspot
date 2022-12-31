import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/category_keyword_block.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';


class SearchMapPage extends StatelessWidget {
  const SearchMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx( () => Scaffold(
      appBar: searchResultPageAppbar(),
      resizeToAvoidBottomInset : false,
      body: Stack(
        children: [
          _map(),
          _drawer()
        ],
      ),
    ));
  }

  _map() => Positioned(
    child: NaverMap(),
  );

  _drawer() => Positioned(
    top: Get.find<SearchPageViewController>().drawer_topSpace.value,
    child: Container(
      width: 390.w,
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
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
                    _searchBoxAndTags(),
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
      Get.find<SearchPageViewController>().updateDrawerTopSpace(value.globalPosition.dy - 100.h);
    },
    child: Container(
      width: 50.w,
      height: 7.h,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      color: Colors.grey,
    ),
  );

  //////////////////////////////////////////////////////////////////////////////searchBox and Tags
  _searchBoxAndTags() => Container(
    padding: EdgeInsets.fromLTRB(21.w, 16.h, 21.w, 23.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _searchBox(),
        SizedBox(height: 23.h,),
        _categoryBox(),
        _keyWordBox(),
      ],
    ),
  );

  _searchBox() => Container(
    width: 317.w,
    height: 48.h,
    child: _inputBox(),
  );

  _inputBox() => Container(
    width: 317.w,
    height: 48.h,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.w),
      color: Color(0xFFFBFBFB),
    ),
    padding: EdgeInsets.fromLTRB(23.w, 0, 17.w, 0),
    child: Row(
      children: [
        Container(
          alignment: Alignment.center,
          height: 48.h,
          width: 260.w,
          child: TextField(
            decoration: InputDecoration(
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
          ),
        ),
        Image.asset("assets/images/search.png", width: 14.w, height: 14.h, color: colorInactive,)
      ],
    ),
  );

  _categoryBox() => Wrap(
    children: List<Widget>.from(Get.find<SearchPageViewController>().categorySelectList.map((element) =>
      GestureDetector(
        child: categoryBlock(element.ifActivated, element.category.emoji, element.category.categoryName),
        onTapUp: (value){
          Get.find<SearchPageViewController>().categoryChange(element);
        },
      ),
    )
  ));

  _categoryBlock(bool ifActivated, String emoji, String categoryName) {
    return GestureDetector(
      child: ifActivated ? Container(
        margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
//    height: 33.h,
        padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: colorPrimary,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: FittedBox(
          child: Text(emoji + categoryName, style: TextStyle(
            fontSize: 14.sp,
            color: colorWhite,
          ),),
        ),
      ) :
      Container(
//    height: 33.h,
        margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
        padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(
                width: 1.w,
                color: colorInactive
            )
        ),
        child: FittedBox(
          child: Text(emoji + categoryName, style: TextStyle(
            fontSize: 14.sp,
            color: colorBlack,
          ),),
        ),
      ),

      onTap: (){
      },
    );
  }

  _keyWordBox() => Wrap(
    children: List<Widget>.from(Get.find<SearchPageViewController>().keyWordSelectList.map((element) =>
      GestureDetector(
        child: keyWordBlock(element.ifActivated, element.keyWord.emoji, element.keyWord.keyWordName),
        onTapUp: (value){
          Get.find<SearchPageViewController>().keyWordChange(element);
        },
      ),
    )
  ));

  _moodBlock(bool ifActivated, String emoji, String moodName) {
    return GestureDetector(
      child: ifActivated ? Container(
        margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
//    height: 33.h,
        padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: colorKeyWordBlock,
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: FittedBox(
          child: Text(emoji + moodName, style: TextStyle(
            fontSize: 16.sp,
            color: colorWhite,
          ),),
        ),
      ) :
      Container(
//    height: 33.h,
        margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
        padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
        decoration: BoxDecoration(
            color: colorBackground,
            borderRadius: BorderRadius.circular(20.w),
            border: Border.all(
                width: 1.w,
                color: colorInactive
            )
        ),
        child: FittedBox(
          child: Text(emoji + moodName, style: TextStyle(
            fontSize: 16.sp,
            color: colorBlack,
          ),),
        ),
      ),

      onTap: (){
      },
    );
  }

  _searchResultList() => Container(
    child: Column(
      children: <Widget>[
        _orderBolck(),
      ]
      + List<Widget>.from(Get.find<SearchPageViewController>().spotList.map(
        (element) => _resultBlock(element.place, element.distance, element.address, element.likes)
      ).toList()),
    ),
  );

  _orderBolck() => Container(
    padding: EdgeInsets.fromLTRB(18.w, 28.h, 18.w, 21.h),
  );

  _resultBlock(String place, int distance, String address, int likes) => Container(
    width: 390.w,
    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFE5E5E5),
          width: 1.h,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(place, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.sp
        ),),
        SizedBox(height: 6.h,),
        Row(
          children: [
            Text(distance.toString() + 'm', style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF737373),
                fontSize: 14.sp
            ),),
            Container(
              width: 1.w,
              height : 20.h,
              margin: EdgeInsets.symmetric(horizontal: 8.w),
              color: Color(0xFFBDBDBD),
            ),
            Text(address, style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF737373),
                fontSize: 14.sp
            ),),
          ],
        ),
        SizedBox(height: 6.h,),
        Row(
          children: [
            Icon(Icons.circle, color: _spotColor(likes), size: 11.w,),
            SizedBox(width: 10.w,),
            Text(NumberFormat("###,###,###").format(likes), style: TextStyle(
                fontWeight: FontWeight.w700,
                color: _spotColor(likes),
                fontSize: 14.sp
            ),),
          ],
        ),
      ],
    ),
  );

  _spotColor(int likes){
    if(likes > 1000) return Color(0xFFEA5252);
    if(likes >  500) return Color(0xFF2BAE5F);
    if(likes >    0) return Color(0xFF0789E8);
  }

}

