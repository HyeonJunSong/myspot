import 'package:flutter/material.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpotDetailPage extends StatefulWidget {
  const SpotDetailPage({Key? key}) : super(key: key);

  @override
  State<SpotDetailPage> createState() => _SpotDetailPageState();
}

class _SpotDetailPageState extends State<SpotDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: buildAppbar('스타벅스 경대북문점'),
      body: Column(
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
          _buildDetail(),
          SizedBox(height: 20.h),
          _buildReviewList(),
        ],
      ),
    );
  }
}

Widget _buildReviewList() {
  final titles = [
    "믿고 먹는 스타벅스입니당 😋",
    "믿고 먹는 스타벅스입니당 😋",
    "믿고 먹는 스타벅스입니당 😋",
    "믿고 먹는 스타벅스입니당 😋"
  ];
  return Expanded(
      child: ListView.separated(
    separatorBuilder: (BuildContext context, int index) => const Divider(),
    itemCount: titles.length,
    itemBuilder: (context, index) {
      return Container(
        padding: EdgeInsets.all(10.w),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: Image.asset(
                    'assets/images/detail_item.png',
                    width: 90.w,
                  ),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titles[index],
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '👍 옵션 여러개 추가 가능하고 검증된 맛',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                        Text(
                          '👎 아무래도 가격이 조금 아쉽스..~',
                          style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              children: _buildKeyword(),
            )
          ],
        ),
      );
    },
  ));
}

Widget _buildDetail() {
  return Container(
    width: double.infinity,
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
      padding: EdgeInsets.all(21.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            '스타벅스 경북대북문점',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
            ),
          ),
          Row(
            children: [
              Text(
                '200m',
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
                '산격동 1399-1',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.sp,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 2.w),
                child: Container(
                  height: 11.h,
                  width: 11.w,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                      color: Colors.red, shape: BoxShape.circle),
                ),
              ),
              SizedBox(width: 10.w),
              Padding(
                padding: EdgeInsets.only(bottom: 3.h),
                child: Text(
                  '1,325',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Colors.red,
                  ),
                ),
              ),
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
                '영연님, 명주님 외 1,323명이 spot! 하였습니다.',
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
    ),
  );
}

List<Widget> _buildKeyword() {
  final keywords = [
    "맛있어요",
    "메뉴가 다양해요",
    "인테리어가 좋아요",
  ];
  return keywords
      .map((e) => Padding(
            padding: EdgeInsets.only(right: 5.w),
            child: Container(
              padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 5.h),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black12),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                e,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                    color: Colors.black),
              ),
            ),
          ))
      .toList();
}
