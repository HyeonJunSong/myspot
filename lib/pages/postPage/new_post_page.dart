import 'package:flutter/material.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  bool showReview = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    return Scaffold(
      appBar: buildAppbar('spot 등록'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(25.w, 45.h, 25.w, 45.h),
            child: Column(
              children: [
                TextField(
                  controller: textEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
                    hintText: "장소를 검색하세요",
                    suffixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey[200],
                  ),
                ),
                TextButton.icon(
                    onPressed: () {
                      //실시간 위치 가져와서 텍스트에 넣기,,,
                    },
                    icon: Icon(
                      Icons.my_location,
                      size: 16.w,
                      color: Colors.black,
                    ),
                    label: Text(
                      "현재 위치로",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ))
              ],
            ),
          ),
          Divider(
            height: 1.h,
          ),
          Container(
            padding: EdgeInsets.all(25.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '한줄평 작성',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (showReview == false) {
                            showReview = true;
                          } else {
                            showReview = false;
                          }
                        });
                      },
                      icon: Icon(showReview
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down),
                    )
                  ],
                ),
                showReview ? buildReview() : Container(),
                Divider(
                  height: 1.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildReview() {
  return Padding(
    padding: EdgeInsets.all(10.w),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '한줄평',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          // controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: colorInactive),
            ),
            contentPadding: EdgeInsets.all(10.w),
            hintText: "한줄평을 입력하세요. (최대20자)",
            hintStyle: TextStyle(fontSize: 14.sp),
          ),
        ),
        Text(
          '👍 좋았던 점은 무엇인가요?',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          // controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: colorInactive),
            ),
            contentPadding: EdgeInsets.all(10.w),
            hintText: "좋았던 점을 간략히 알려주세요. (최대20자)",
            hintStyle: TextStyle(fontSize: 14.sp),
          ),
        ),
        Text(
          '👎 아쉬웠던 점은 무엇인가요?',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        TextField(
          // controller: textEditingController,
          maxLength: 20,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: const BorderSide(color: colorInactive),
            ),
            contentPadding: EdgeInsets.all(10.w),
            hintText: "아쉬웠던 점을 간략히 알려주세요. (최대20자)",
            hintStyle: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    ),
  );
}
