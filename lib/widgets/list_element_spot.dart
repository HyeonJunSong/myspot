import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';

Widget listElementSpot(Spot spot) => GestureDetector(
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
            Icon(Icons.circle, color: spotColor(spot.spotNum), size: 11.w,),
            SizedBox(width: 10.w,),
            Text(NumberFormat("###,###,###").format(spot.spotNum), style: TextStyle(
                fontWeight: FontWeight.w700,
                color: spotColor(spot.spotNum),
                fontSize: 14.sp
            ),),
          ],
        ),
      ],
    ),
  ),
);