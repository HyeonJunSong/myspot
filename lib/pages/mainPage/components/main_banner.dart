import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/utils/constants.dart';

import '../../../viewModels/user_controller.dart';
import '../../../widgets/dialog_location_setting.dart';

Widget buildMainBanner() {
  return Container(
    height: 180.h,
    // padding: EdgeInsets.only(top: 50.h),
    decoration: BoxDecoration(
      color: colorPrimary,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
    ),
    child: Padding(
      padding: EdgeInsets.fromLTRB(40.w, 0.h, 40.w, 30.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* 위치 설정 및 주소*/
              Obx(() => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        // 위치 설정
                        child: Text(
                          "위치 설정",
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Get.dialog(const DialogLocationSetting());
                        },
                      ),
                      Text(
                        // 주소
                        "${Get.find<UserController>().setAddressUpper.value} ${Get.find<UserController>().setAddressLower.value}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  )),

              /* 프로필 */
              GestureDetector(
                onTap: () => Get.toNamed("/MyPage"),
                child: SizedBox(
                  width: 44.w,
                  child: const Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 22,
                      // backgroundImage: NetworkImage(userAvatarUrl),
                      backgroundColor: colorInactive,
                      foregroundColor: Colors.white,
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
