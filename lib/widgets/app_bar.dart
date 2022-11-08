import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/widgets/dialog_location_setting.dart';

PreferredSizeWidget buildAppbar(String label) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 1.sp,
    leading: _leading(),
    title: Text(
      label,
      style: _textStyle(TextDecoration.none)
    ),
  );
}

searchResultPageAppbar() => AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 1.sp,
  leading: _leading(),
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        child: Text("대학로 80", style: _textStyle(TextDecoration.underline)),
        onTap: (){Get.dialog(DialogLocationSetting());},
      ),
      Text(" 주변 HotSpot", style: _textStyle(TextDecoration.none)),
    ],
  ),
);

searchPageAppbar() => AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 1.sp,
  leading: _leading(),
  title: GestureDetector(
    child: Text("대학로 80", style: _textStyle(TextDecoration.underline)),
    onTap: (){Get.dialog(DialogLocationSetting());},
  ),
);


////////////////////////////////////////////////////////////////////////////////

_leading() => IconButton(
  icon: Icon(
    Icons.arrow_back_ios,
    size: 12.h,
    color: Colors.black,
  ),
  onPressed: () {
    Get.back();
  },
);

_textStyle(TextDecoration decoration) => TextStyle(
  decoration: decoration,
  color: Colors.black,
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
);