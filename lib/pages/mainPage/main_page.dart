import 'package:flutter/material.dart';
import 'package:myspot/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/widgets/circle_button.dart';

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
                height: 172.h,
                width: 317.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Text(
                        "위치설정",
                        style: TextStyle(
                          fontSize: 14.sp,
                        ),
                      ),
                      onTap: () {},
                    ),
                    Text(
                      "상세주소1",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      "상세주소2",
                      style: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Text("프로필버튼"),
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
