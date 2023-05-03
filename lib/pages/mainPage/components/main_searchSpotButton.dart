import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/utils/constants.dart';

Widget buildSearchSpotButton() {
  return GestureDetector(
    onTap: () => Get.toNamed("/Search"),
    child: Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 96.h,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [colorPrimary, Color(0xFF7D0080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5.r,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "주변 Spot 찾아보기",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    "내 주변 Spot들을 탐색해보세요.",
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
