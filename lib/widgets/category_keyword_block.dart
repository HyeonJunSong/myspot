
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';

class _Block extends StatelessWidget {
  bool ifCategory;
  bool ifActivated;
  String emoji;
  String name;
  double? width;
  double? height;

  _Block({
    Key? key,
    required this.ifCategory,
    required this.ifActivated,
    required this.emoji,
    required this.name,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 11.w, bottom: 5.h),
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 6.5.h, horizontal: 20.w),
      decoration: BoxDecoration(
          color: ifActivated ? (ifCategory ? colorPrimary : colorKeyWordBlock) : colorBackground,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(
              width: 1.w,
              color: ifActivated ? (ifCategory ? colorPrimary : colorKeyWordBlock) : colorInactive
          )
      ),
      child: FittedBox(
        child: Text(emoji + name, style: TextStyle(
          fontSize: 16.sp,
          color: ifActivated ? colorWhite : colorBlack,
        ),),
      ),
    );
  }
}

class CategoryBlock extends StatelessWidget{
  final bool ifActivated;
  final String emoji;
  final String categoryName;
  final double? width;
  final double? height;

  const CategoryBlock({
    Key? key,
    required this.ifActivated,
    required this.emoji,
    required this.categoryName,
    this.width,
    this.height,
  }) : super(key: key);

  factory CategoryBlock.fromCategoryIndActivated(int categoryInd){
    return CategoryBlock(
      ifActivated: true,
      emoji: categoryList[categoryInd].emoji,
      categoryName: categoryList[categoryInd].categoryName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Block(
      ifCategory: true,
      ifActivated: ifActivated,
      emoji: emoji,
      name: categoryName,
      width: width,
      height: height,
    );
  }
}

class KeyWordBlock extends StatelessWidget{
  final bool ifActivated;
  final String emoji;
  final String keyWordName;
  final double? width;
  final double? height;

  const KeyWordBlock({
    Key? key,
    required this.ifActivated,
    required this.emoji,
    required this.keyWordName,
    this.width,
    this.height,
  }) : super(key: key);

  factory KeyWordBlock.fromKeyWordIndActivated(int keyWordInd){
    return KeyWordBlock(
      ifActivated: true,
      emoji: keyWordList[Get.find<SearchPageViewController>().categoryInd.value][keyWordInd].emoji,
      keyWordName: keyWordList[Get.find<SearchPageViewController>().categoryInd.value][keyWordInd].keyWordName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _Block(
      ifCategory: false,
      ifActivated: ifActivated,
      emoji: emoji,
      name: keyWordName,
      width: width,
      height: height,
    );
  }
}