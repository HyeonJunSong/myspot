import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';

class NewPostPage extends StatefulWidget {
  const NewPostPage({super.key});

  @override
  State<NewPostPage> createState() => _NewPostPageState();
}

class _NewPostPageState extends State<NewPostPage> {
  List<bool> show = [false, false, false];

  List<XFile>? _imageFileList;

  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController maxWidthController = TextEditingController();
  final TextEditingController maxHeightController = TextEditingController();
  final TextEditingController qualityController = TextEditingController();
  String? _retrieveDataError;

  final List<String> _tags = [];
  final FocusNode focusNode = FocusNode();
  final TextEditingController tagController = TextEditingController();

  _onDelete(index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  @override
  void dispose() {
    maxWidthController.dispose();
    maxHeightController.dispose();
    qualityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar('spot 등록'),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25.w, 45.h, 25.w, 45.h),
              child: Column(
                children: [
                  TextField(
                    controller: locationController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
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
            Expanded(
              child: SingleChildScrollView(
                // padding: EdgeInsets.all(25.w),
                child: Column(
                  children: [
                    _buildReview(),
                    Divider(height: 1.h),
                    _buildTag(),
                    Divider(height: 1.h),
                    _buildImg(),
                    Divider(height: 1.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReview() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 15.h),
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
                    if (show[0] == false) {
                      show[0] = true;
                    } else {
                      show[0] = false;
                    }
                  });
                },
                icon: Icon(show[0]
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              )
            ],
          ),
          show[0] ? _buildReviewContent() : Container(),
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

  Widget _buildTag() {
    return Padding(
      padding: EdgeInsets.fromLTRB(25.w, 15.h, 25.w, 15.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '태그 추가',
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
                icon: Icon(show[1]
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down),
              )
            ],
          ),
          show[1] ? _buildTagContent() : Container(),
        ],
      ),
    );
  }

  Widget _buildTagContent() {
    return Padding(
      padding: EdgeInsets.all(10.w),
      child: TagEditor(
        length: _tags.length,
        controller: tagController,
        focusNode: focusNode,
        autofocus: true,
        delimiters: [',', ' '],
        hasAddButton: true,
        resetTextOnSubmitted: true,
        // This is set to grey just to illustrate the `textStyle` prop
        textStyle: const TextStyle(color: Colors.grey),
        onSubmitted: (outstandingValue) {
          setState(() {
            _tags.add(outstandingValue);
          });
        },
        inputDecoration: const InputDecoration(
          border: InputBorder.none,
          hintText: '#태그',
        ),
        onTagChanged: (newValue) {
          setState(() {
            _tags.add(newValue);
          });
        },
        tagBuilder: (context, index) => _Chip(
          index: index,
          label: _tags[index],
          onDeleted: _onDelete,
        ),
        // InputFormatters example, this disallow \ and /
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'[/\\]'))],
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
                    if (show[2] == false) {
                      show[2] = true;
                    } else {
                      show[2] = false;
                    }
                  });
                },
                icon:
                    Icon(show[2] ? Icons.add_circle : Icons.add_circle_outline),
              )
            ],
          ),
          show[2] ? _buildImgContent(context) : Container(),
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
