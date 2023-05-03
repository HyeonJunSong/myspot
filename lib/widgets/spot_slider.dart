import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
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
    return Container(
      padding: EdgeInsets.only(bottom: 18.h),
      child: Column(
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
          SizedBox(height: 10.h),
          /* spot 슬라이드뷰 */
          CarouselSlider(
            options: CarouselOptions(
              height: 126.h,
              aspectRatio: 166 / 129,
              viewportFraction: 0.5,
              autoPlay: false,
            ),
            items: spots.map((s) {
              return Builder(builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: Container(
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
                          Image.asset(
                            "assets/images/detail_background.png",
                            fit: BoxFit.fill,
                          ),
                          Container(
                            padding: EdgeInsets.all(10.w),
                            width: double.infinity,
                            height: 50.h,
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "스타벅스 경북대북문점",
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "220m | 산격동 1399-1",
                                  style: TextStyle(
                                    fontSize: 8.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            }).toList(),
          ),
        ],
      ),
    );
  }
}
