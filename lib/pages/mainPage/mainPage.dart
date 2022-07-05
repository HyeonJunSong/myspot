import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myspot/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/widgets/circleButton.dart';

class mainPage extends StatelessWidget {
  const mainPage({Key? key}) : super(key: key);

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
                  Spacer(),
                  circleButton(
                    diameter: 48.w > 48.h ? 48.w: 48.h,
                    image: "images/circleButton_cross.png"
                  ),
                  SizedBox(width: 9.w,),
                  circleButton(
                      diameter: 48.w > 48.h ? 48.w: 48.h,
                      image: "images/circleButton_dots.png"
                  ),
                ],
              ),

              SizedBox(height: 153.h,),

              //위치설정, 위치, 검색

              Container(
                height: 172.h,
                width: 317.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      child: Text("위치설정", style: TextStyle(
                        fontSize: 14.sp,
                      ),),
                      onTap: (){},
                    ),
                    Text("상세주소1", style: TextStyle(
                      fontSize: 14.sp,
                    ),),
                    Text("상세주소2", style: TextStyle(
                      fontSize: 14.sp,
                    ),),
                    ElevatedButton(
                      onPressed: (){},
                      child: Text("프로필버튼"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
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
