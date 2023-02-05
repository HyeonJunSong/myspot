import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/viewModels/post_page_view_controller.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/dialog_location_setting.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

PreferredSizeWidget buildAppbar(String label) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.white,
    elevation: 1.sp,
    leading: _leading(),
    toolbarHeight: 65.h,
    title: Text(
      label,
      style: _textStyle(TextDecoration.none)
    ),
  );
}


searchPageAppbar() => AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 1.sp,
  leading: _leading(),
  toolbarHeight: 65.h,
  title: GestureDetector(
    child: Text("대학로 80", style: _textStyle(TextDecoration.underline)),
    onTap: (){Get.dialog(DialogLocationSetting());},
  ),
);

searchMapPageAppbar() => AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 1.sp,
  leading: _leading(),
  toolbarHeight: 65.h,
  title: Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      GestureDetector(
        child: Text("대학로 80", style: _textStyle(TextDecoration.underline)),
        onTap: () async{
          LatLng coor = await Get.dialog(DialogLocationSetting());
          coor == null ? null : Get.find<SearchPageViewController>().updateCurCamPostion(coor);
        },
      ),
      Text(" 주변 HotSpot", style: _textStyle(TextDecoration.none)),
    ],
  ),
);

postMapPageAppbar() => AppBar(
  centerTitle: true,
  backgroundColor: Colors.white,
  elevation: 1.sp,
  leading: _leading(),
  toolbarHeight: 65.h,
  title: GestureDetector(
    child: Text("대학로 80", style: _textStyle(TextDecoration.underline)),
    onTap: () async {
      LatLng coor = await Get.dialog(DialogLocationSetting());
      coor == null ? null : Get.find<PostPageViewController>().updateCurCamPostion(coor);
    },
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