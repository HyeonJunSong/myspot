import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/utils/constants.dart';

class DialogLocationSetting extends StatelessWidget {
  const DialogLocationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      insetPadding: EdgeInsets.all(0.w),
      child: SizedBox(
        width: 354.w,
        height: 221.h,
        child: Column(
          children: [
            Container(
              height: 56.h,
              width: 354.w,
             padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
              child: Row(
                children:[
                  GestureDetector(
                    child: Image.asset("assets/images/close.png",),
                    onTap: (){
                      Get.back();
                    },
                  ),
                  SizedBox(width: 109.w),
                  Text("위치 설정", style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),),
                  SizedBox(width: 125.w,),
                ]
              )
            ),
            Divider(
              height: 0.h,
             thickness: 2,
              color: colorInactive,
            ),
            SizedBox(
              height: 165.h,
              width: 354.w,
              child: Column(
              )
            ),
          ],
        ),
      ),
    );
  }
}
