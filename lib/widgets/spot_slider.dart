import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:myspot/models/spot.dart';

class SpotSlider extends StatelessWidget {
  final List<Spot> spots;
  final String tag;
  final List<Color> tagColors;
  const SpotSlider(
      {super.key,
      required this.spots,
      required this.tag,
      required this.tagColors});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* 해시테그 문구 */
        FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            height: 24.h,
            decoration: BoxDecoration(
                border: GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: tagColors,
                  ),
                  width: 1.w,
                ),
                borderRadius: BorderRadius.circular(16)),
            child: Center(
              child: Text(
                tag,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 13.h),
        /* spot 슬라이드뷰 */
        CarouselSlider(
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            autoPlay: true,
          ),
          items: spots.map((s) {
            return Builder(builder: (BuildContext context) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 5.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 5.r,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Column(
                    children: [
                      Expanded(
                        child: Image.asset(
                          "assets/images/detail_background.png",
                          fit: BoxFit.fill,
                          width: double.infinity,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(8.w),
                        width: double.infinity,
                        height: 80.h,
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "스타벅스 경북대북문점",
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              "220m | 산격동 1399-1",
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
          }).toList(),
        ),
      ],
    );
  }
}
