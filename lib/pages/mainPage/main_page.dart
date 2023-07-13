import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/pages/mainPage/components/main_popularSpot.dart';
import 'package:myspot/pages/mainPage/components/main_searchSpotButton.dart';
import 'package:myspot/pages/mainPage/components/main_addSpotButton.dart';
import 'package:myspot/pages/mainPage/components/main_banner.dart';
import 'package:myspot/utils/constants.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            /*  배너: 위치 및 프로필 */
            buildMainBanner(),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  /* spot 등록 및 검색으로 이동 */
                  Column(
                    children: [
                      buildAddSpotButton(),
                      SizedBox(height: 11.h),
                      buildSearchSpotButton(),
                    ],
                  ),
                  SizedBox(height: 29.h,),
                  /* 내주변 인기 spot */
                  buildPopularSpot(),
                  SizedBox(height: 3.h)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
