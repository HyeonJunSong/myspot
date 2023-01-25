import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_mood.dart';
import 'package:myspot/pages/searchResultPage/search_result_page.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_map_view_controller.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/categoryAndmood_block.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class SearchMapPage extends StatelessWidget {
  const SearchMapPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx( () => Scaffold(
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
    top: Get.find<SearchMapViewController>().drawer_topSpace.value,
    child: Container(
      width: 390.w,
      height: 844.h,
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        color: colorWhite
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _knob(),
          _searchBoxAndTags(),
          Divider(thickness: 1.h,),
          _searchResultList()
        ],
      ),
    ),
  );

  _knob() => GestureDetector(
    onVerticalDragUpdate: (value){
      Get.find<SearchMapViewController>().updateDrawerTopSpace(value.globalPosition.dy);
    },
    child: Container(
      width: 50.w,
      height: 5.h,
      padding: EdgeInsets.symmetric(vertical: 20.h),
      color: Colors.grey,
    ),
  );

  //////////////////////////////////////////////////////////////////////////////searchBox and Tags
  _searchBoxAndTags() => Container(
    padding: EdgeInsets.fromLTRB(21.w, 16.h, 21.w, 23.h),
    child: Column(
      children: [
        _searchBox(),
        SizedBox(height: 23.h,),
        _categoryBox(),
        _moodBox(),
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

  _categoryBox() => Container(
    width: 310.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
            children: List<Widget>.from(<category>[
              category(true, "🍽", "밥집"),
              category(false, "☕", "카페"),
              category(false, "🍺", "술집"),
            ].map((element) =>
                categoryBlock(element.inActivated, element.emoji, element.categoryName),
            ))
        ),
      ],
    ),
  );

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

  _moodBox() => Container(
    width: 310.w,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
            children: List<Widget>.from([
              tag(true, "✨", "분위기"),
              tag(false, "💸", "가성비"),
            ].map((element) =>
                moodBlock(element.inActivated, element.emoji, element.moodName),
            ))
        ),
      ],
    ),
  );

  _moodBlock(bool ifActivated, String emoji, String moodName) {
    return GestureDetector(
      child: ifActivated ? Container(
        margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
//    height: 33.h,
        padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
        decoration: BoxDecoration(
          color: colorMoodBlock,
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

  _searchResultList() => Container();

  _resultBlock(String place, String distance, String address, int likes) => Container(
    width: 390.w,
    child: Column(
      children: [
        Text(place, style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16.sp
        ),),
        SizedBox(height: 6.h,),
        Row(
          children: [
            Text(distance+'m', style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Color(0xFF737373),
                fontSize: 14.sp
            ),),
            VerticalDivider(

            ),
          ],
        )
      ],
    ),
  );

}

