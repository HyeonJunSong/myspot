import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/models/post.dart';
import 'package:myspot/services/api.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/post_page_view_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myspot/widgets/category_keyword_block.dart';
import 'package:myspot/widgets/rounded_button.dart';
import '../../viewModels/search_page_view_controller.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  List<bool> show = [false, false];

  List<XFile>? _imageFileList;

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  String? _retrieveDataError;

  final FocusNode focusNode = FocusNode();
  final TextEditingController tagController = TextEditingController();

  late ApiResponse _apiResponse;

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: buildAppbar('spot 등록'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 45.h, 25.w, 25.h),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.toNamed("/PostMap");
                    },
                    child: Container(
                      width: 335.w,
                      height: 48.h,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      decoration: BoxDecoration(
                        color: colorInactive,
                        borderRadius: BorderRadius.all(Radius.circular(20.r)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            Get.find<PostPageViewController>().location.value.placeName.isEmpty ?
                            "장소를 검색하세요." : Get.find<PostPageViewController>().location.value.placeName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                            ),
                          ),
                          Icon(Icons.search, size: 14.w,color: Colors.black,)
                        ],
                      ),
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
                    )
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                // padding: EdgeInsets.all(25.w),
                child: Column(
                  children: [
                    _buildCategory(),
                    Divider(height: 1.h),
                    _buildReview(),
                    Divider(height: 1.h),
                    _buildImg(),
                    Divider(height: 1.h),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15.h),
              child: RoundedButton(
                onPressed: () async {
                  Get.find<PostPageViewController>().post();
                  // _post.email = "test@test.com";
                  // _post.spotName = "newLocation";
                  // _post.category = "밥집";
                  // _post.comment = "연어초밥이 죽여줘요ㅠㅠ";
                  //
                  // _apiResponse = await addNewPost(_post);
                  // if (_apiResponse.apiError == null) {
                  //   debugPrint(_apiResponse.data.toString());
                  //   Get.defaultDialog(
                  //     radius: 10,
                  //     title: "spot 등록",
                  //     middleText: "스팟이 등록되었습니다",
                  //   );
                  // } else {
                  //   debugPrint((_apiResponse.apiError as ApiError).error);
                  //   Get.defaultDialog(
                  //     radius: 10,
                  //     title: "spot 등록",
                  //     middleText: "스팟이 정상적으로 등록되지 못했습니다.\n다시 시도해주세요.",
                  //   );
                  // }
                  //
                  // //게시물 확인
                  // // _apiResponse = await getPost(_post.email!);
                  // // if (_apiResponse.apiError == null) {
                  // //   debugPrint(_apiResponse.data.toString());
                  // // } else {
                  // //   debugPrint((_apiResponse.apiError as ApiError).error);
                  // // }
                },
                label: '등록 하기',
                width: 275.w,
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _buildReview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 15.h),
      child: Column(
        children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       '한줄평 작성',
          //       style: TextStyle(
          //         fontSize: 16.sp,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //     IconButton(
          //       onPressed: () {
          //         setState(() {
          //           if (show[0] == false) {
          //             show[0] = true;
          //           } else {
          //             show[0] = false;
          //           }
          //         });
          //       },
          //       icon: Icon(show[0]
          //           ? Icons.keyboard_arrow_up
          //           : Icons.keyboard_arrow_down),
          //     )
          //   ],
          // ),
          _buildReviewContent(),
        ],
      ),
    );
  }

  Widget _buildReviewContent() {
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
        ],
      ),
    );
  }

  Widget _buildCategory() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 15.h),
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "카테고리 선택",
                style: TextStyle(
                  color: colorBlack,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 16.sp,
              ),
              Wrap(
                children: List<Widget>.from(
                  Get.find<PostPageViewController>()
                  .categorySelectList
                  .map(
                    (element) => GestureDetector(
                      child: categoryBlock(
                        element.ifActivated,
                        element.category.emoji,
                        element.category.categoryName),
                      onTap: () {
                        Get.find<PostPageViewController>()
                        .categoryChange(element);
                      },
                    ),
                  )
                )
              ),
              //
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            width: 310.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "키워드 선택",
                  style: TextStyle(
                    color: colorBlack,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 16.sp,
                ),
                Wrap(
                  children: List<Widget>.from(
                    Get.find<PostPageViewController>()
                    .keyWordSelectList
                    .map(
                      (element) => GestureDetector(
                        child: keyWordBlock(
                            element.ifActivated,
                            element.keyWord.emoji,
                            element.keyWord.keyWordName),
                        onTap: () {
                          Get.find<PostPageViewController>()
                            .keyWordChange(element);
                        },
                      ),
                    )
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImg() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 15.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '사진 추가',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    if (show[1] == false) {
                      show[1] = true;
                    } else {
                      show[1] = false;
                    }
                  });
                },
                icon:
                    Icon(show[1] ? Icons.add_circle : Icons.add_circle_outline),
              )
            ],
          ),
          show[1] ? _buildImgContent(context) : Container(),
        ],
      ),
    );
  }

  Widget _buildImgContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: _previewImages(context),
    );
  }

  Future _getImage(BuildContext context) async {
    try {
      final List<XFile> pickedFileList = await _picker.pickMultiImage();
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages(BuildContext context) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              key: UniqueKey(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: EdgeInsets.only(right: 10.w),
                  child: kIsWeb
                      ? Image.network(
                          _imageFileList![index].path,
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.fill,
                        )
                      : Image.file(
                          File(_imageFileList![index].path),
                          width: 100.w,
                          height: 100.h,
                          fit: BoxFit.fill,
                        ),
                );
              },
              itemCount: _imageFileList!.length,
            ),
          ),
          TextButton(
            onPressed: () => _getImage(context),
            child: const Text('수정'),
          ),
        ],
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return IconButton(
          onPressed: () => _getImage(context),
          icon: const Icon(Icons.add_a_photo_outlined));
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  final String label;
  final ValueChanged<int> onDeleted;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: label.startsWith('#') ? Text(label) : Text("#$label"),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}
