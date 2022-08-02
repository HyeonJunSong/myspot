import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/models/locations.dart';
import 'package:myspot/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/widgets/circle_button.dart';
import 'package:myspot/widgets/dialog_location_setting.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: Container(
        padding: EdgeInsets.fromLTRB(16.w, 73.h, 16.w, 0),
        child: Center(
          child: Column(
            children: <Widget>[
              //십자버튼, 프로필버튼
              Row(
                children: <Widget>[
                  const Spacer(),
                  CircleButton(
                      diameter: 48.w > 48.h ? 48.w : 48.h,
                      image: "assets/images/circleButton_cross.png"),
                  SizedBox(
                    width: 9.w,
                  ),
                  CircleButton(
                      diameter: 48.w > 48.h ? 48.w : 48.h,
                      image: "assets/images/circleButton_dots.png"),
                ],
              ),

              SizedBox(
                height: 153.h,
              ),

              //위치설정, 위치, 검색
              SizedBox(
                width: 317.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        "위치 설정",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF737373),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      onTap: () {
                        updateCity();
                        Get.dialog(const DialogLocationSetting());
                      },
                    ),
                    Text(
                      "상세주소1",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "상세주소2",
                      style: TextStyle(
                        fontSize: 32.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(23.w, 17.h, 17.w, 17.h),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: colorInactive,
                          ),
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.r))),
                      child: Row(
                        children: [
                          Text(
                            "분위기 좋은 식당",
                            style: TextStyle(
                                color: colorInactive,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          Image.asset(
                            "assets/images/search.png",
                            width: 16.w,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //HotSpot탐색바
            ],
          ),
        ),
      ),
    );
  }
}
