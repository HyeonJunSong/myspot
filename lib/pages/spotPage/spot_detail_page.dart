import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myspot/models/review.dart';
import 'package:myspot/models/spot.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/widgets/list_element_review.dart';

class SpotDetailPage extends StatefulWidget {
  const SpotDetailPage({Key? key}) : super(key: key);

  @override
  State<SpotDetailPage> createState() => _SpotDetailPageState();
}

class _SpotDetailPageState extends State<SpotDetailPage> {
  @override
  Widget build(BuildContext context) {
    final Spot spot = Get.arguments as Spot;
    print(spot.distance);
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: buildAppbar(spot.placeName),
      body: Column(
        children: [
          _spotSection(spot),
          SizedBox(height: 20.h),
          _reviewList(),
        ],
      ),
    );
  }

  _spotSection(Spot spot) => Column(
    children: [
      Container(
        height: 167.h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/detail_background.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      _buildDetail(spot),
    ],
  );
}

Widget _buildDetail(Spot spot) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(21.w),
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          spot.placeName,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
          ),
        ),
        Row(
          children: [
            Text(
              '${spot.distance}m',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black54,
              ),
            ),
            Text(
              ' | ',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black45,
              ),
            ),
            Text(
              spot.address,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.sp,
                color: Colors.black54,
              ),
            ),
          ],
        ),
        Row(
          children: [
            Icon(Icons.circle, color: _spotColor(spot.spotNum), size: 11.w,),
            SizedBox(width: 10.w,),
            Text(NumberFormat("###,###,###").format(spot.spotNum), style: TextStyle(
                fontWeight: FontWeight.w700,
                color: _spotColor(spot.spotNum),
                fontSize: 14.sp
            ),),
          ],
        ),
        Row(
          children: [
            Container(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              child: Icon(
                Icons.place,
                color: colorPrimary,
                size: 15.w,
              ),
            ),
            SizedBox(width: 5.w),
            Text(
              '${spot.spotNum}명이 spot! 하였습니다.',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Colors.black45,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _reviewList(){
  return Get.find<SearchPageViewController>().reviewList.isEmpty ? Container() : Column(
    children: List<Widget>.from(Get.find<SearchPageViewController>().reviewList.map((e) => listElementReview(e)))
  );
}

// List<Review> _tempPost = [
//   Review(
//     comment: "믿고 먹는 스타벅스입니당 😋",
//     user_email: "yanyanzzi",
//   ),
//   Review(
//     comment: "믿고 먹는 스타벅스입니당 😋",
//     user_email: "yanyanzzi",
//   ),
//   Review(
//     comment: "믿고 먹는 스타벅스입니당 😋",
//     user_email: "yanyanzzi",
//   ),
//   Review(
//     comment: "믿고 먹는 스타벅스입니당 😋",
//     user_email: "yanyanzzi",
//   ),
//   Review(
//     comment: "믿고 먹는 스타벅스입니당 😋",
//     user_email: "yanyanzzi",
//   ),
// ];

_spotColor(int likes){
  if(likes > 1000) return Color(0xFFEA5252);
  if(likes >  500) return Color(0xFF2BAE5F);
  if(likes >    0) return Color(0xFF0789E8);
}

