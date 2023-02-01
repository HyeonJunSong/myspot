import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/category_keyword_block.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchPageAppbar(),
      body: SingleChildScrollView(
        child: Obx(() => Column(
          children: [
            SizedBox(height: 40.h,),
            _searchBox(),
            Divider(height: 66.h, thickness: 1.h,),
            _categoryBox(),
            SizedBox(height: 38.h,),
            _keyWordBox(),
            SizedBox(height: 50.h,),
            _button(),
          ],
        )),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////elements
_searchBox() => Container(
  width: 317.w,
  height: 80.h,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text("직접 입력", style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),),
      _inputBox(),
    ],
  ),
);

_inputBox() => Container(
  width: 317.w,
  height: 48.h,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20.w),
    color: Color(0xFFFBFBFB),
  ),
  padding: EdgeInsets.fromLTRB(23.w, 0, 17.w, 0),
  child: Row(
    children: [
      Container(
        alignment: Alignment.center,
        height: 48.h,
        width: 260.w,
        child: TextField(
          decoration: InputDecoration(
            isDense: true,
            hintText: "가게명, 메뉴 검색",
            hintStyle: TextStyle(
              color: colorInactive,
              fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent),),
            contentPadding: EdgeInsets.all(0),
          ),
          style: TextStyle(
            color: colorInactive,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textAlignVertical: TextAlignVertical.center,
          cursorColor: colorInactive,
        ),
      ),
      Image.asset("assets/images/search.png", width: 14.w, height: 14.h, color: colorInactive,)
    ],
  ),
);

_categoryBox() => Container(
  width: 310.w,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("카테고리 선택", style: TextStyle(
        color: colorBlack,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),),
      SizedBox(height: 16.sp,),
      Wrap(
        children: List<Widget>.from(Get.find<SearchPageViewController>().categorySelectList.map((element) =>
          GestureDetector(
            child: categoryBlock(element.ifActivated, element.category.emoji, element.category.categoryName),
            onTapUp: (value){
            Get.find<SearchPageViewController>().categoryChange(element);
            },
          ),
        )
      )),
    ],
  ),
);

_keyWordBox() => Container(
  width: 310.w,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("키워드 선택", style: TextStyle(
        color: colorBlack,
        fontSize: 16.sp,
        fontWeight: FontWeight.w700,
      ),),
      SizedBox(height: 16.sp,),
      Wrap(
        children: List<Widget>.from(Get.find<SearchPageViewController>().keyWordSelectList.map((element) =>
          GestureDetector(
            child: keyWordBlock(element.ifActivated, element.keyWord.emoji, element.keyWord.keyWordName),
            onTapUp: (value){
              Get.find<SearchPageViewController>().keyWordChange(element);
            },
          ),
        ))
      ),
    ],
  ),
);

_button() => ElevatedButton(
    onPressed: (){
      Get.toNamed("/SearchMap");
    },
    style: ElevatedButton.styleFrom(
      fixedSize: Size(275.w, 42.h),
      backgroundColor: colorPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.w)),
    ),
    child: Text("필터 설정 완료!")
);