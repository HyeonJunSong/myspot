import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget buildAppbar(String label) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 1.sp,
    leading: IconButton(
      icon: Icon(
        Icons.arrow_back_ios,
        size: 12.h,
        color: Colors.black,
      ),
      onPressed: () {
        Get.back();
      },
    ),
    title: Text(
      label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),
    ),
  );
}
