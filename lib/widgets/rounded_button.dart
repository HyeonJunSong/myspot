import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget roundedButoon(
  Function()? onPressed,
  Widget icon,
  String label,
  double width,
  Color textColor,
  Color btnColor,
) {
  return SizedBox(
    width: width,
    height: 42.h,
    child: ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: btnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
      ),
    ),
  );
}
