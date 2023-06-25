import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/viewModels/my_page_view_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:myspot/widgets/list_element_spot.dart';

Widget mySpotList(){
  return Column(
    children: <Widget>[
      Container(
        width: 390.w,
        height: 73.h,
        padding: EdgeInsets.symmetric(horizontal: 26.w),
        child: Row(
          children: [
            Text(
              '${Get.find<UserController>().user.value.nickname}의 mySpot',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: (){
                Get.find<MyPageViewController>().toggleMySpot();
              },
              child: Get.find<MyPageViewController>().mySpotToggle.value
                  ? Icon(Icons.keyboard_arrow_up, color: Colors.black,)
                  : Icon(Icons.keyboard_arrow_down, color: Colors.black,),
            ),
          ],
        ),
      ),
    ]
    + (Get.find<MyPageViewController>().mySpotToggle.value
    ? Get.find<MyPageViewController>().mySpotList.map((spot) => listElementSpot(spot)).toList()
    : []),
  );
}