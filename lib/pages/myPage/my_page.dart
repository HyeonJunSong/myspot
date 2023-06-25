import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/pages/myPage/widgetMySpotList.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/my_page_view_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'widgetMyReviewList.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: buildAppbar('계정'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfile(),
            SizedBox(height: 46.h),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: colorInactive,
            ),
            mySpotList(),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: colorInactive,
            ),
            myReviewList(),
            Divider(
              height: 1.h,
              thickness: 1.h,
              color: colorInactive,
            ),
          ],
        ),
      )
    ));
  }
}

Widget _buildProfile() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 5.r,
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(26.w),
      child: Row(
        children: [
          const Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              // backgroundImage: NetworkImage(userAvatarUrl),
              backgroundColor: Colors.black12,
              foregroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          SizedBox(width: 13.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Get.find<UserController>().user.value.nickname ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  //구글계정인 경우만 로고넣기
                  Image.asset(
                    'assets/images/google_blue.png',
                    height: 12.h,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    Get.find<UserController>().user.value.email ?? '',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}