import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';

AppBar signUpInAppBar(String label){
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

////////////////////////////////////////////////////////////////////////////////

_leading() => IconButton(
  icon: Icon(
    Icons.arrow_back_ios,
    size: 12.h,
    color: Colors.black,
  ),
  onPressed: () {
    Get.find<SignUpInPageController>().refreshControllers();
    Get.offAndToNamed("/SignUpIn");
  },
);

_textStyle(TextDecoration decoration) => TextStyle(
  decoration: decoration,
  color: Colors.black,
  fontSize: 16.sp,
  fontWeight: FontWeight.w700,
);