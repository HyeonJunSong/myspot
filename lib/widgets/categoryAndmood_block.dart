
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';

categoryBlock(bool ifActivated, String emoji, String categoryName) {
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
        child: Text(emoji + categoryName, style: TextStyle(
          fontSize: 16.sp,
          color: colorBlack,
        ),),
      ),
    ),

    onTap: (){
    },
  );
}

moodBlock(bool ifActivated, String emoji, String moodName) {
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