import 'package:flutter/material.dart';
import 'package:myspot/models/review.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/utils/constants.dart';

Widget listElementReview(Review post){
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 10.h),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: colorInactive,
          width: 1.w,
        ),
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        post.image == "" ?
          Container() :
          Container(
            margin: EdgeInsets.only(bottom: 10.h),
            height: 120.h,
            child: Image.network(post.image),
          ),
        Row(
          children: [
            Container(
              child: Text(
                post.comment.isEmpty ? "리뷰가 없습니다." : post.comment,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(width: 16.w,),
            Column(
              children: [
                Text(post.user_email, style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF737373),
                    fontSize: 12.sp
                ),),
                Text("2023.02.03. 14:30", style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF737373),
                    fontSize: 12.sp
                ),),
              ],
            )
          ]
        ),
      ],
    ),
  );
}