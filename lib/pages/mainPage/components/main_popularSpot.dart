import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/widgets/spot_slider.dart';
import '../../../models/spot.dart';

Widget buildPopularSpot() {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "내 주변 인기 Spot",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "어디 갈지 고민된다면? 내 주변 인기 Spot들로 구성해보았어요.",
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 18.h),
          SpotSlider(
            spots: List.filled(4, Spot()),
            tag: '#Spot 100회 이상',
            tagColors: const [Color(0xFF3763FF), Color(0xFFFF5CE5)],
          ),
          SpotSlider(
            spots: List.filled(4, Spot()),
            tag: '#현 위치에서 500m 이내',
            tagColors: [Color(0xFF9BDB49), Color(0xFFFF5858)],
          ),
        ],
      ),
    ],
  );
}
