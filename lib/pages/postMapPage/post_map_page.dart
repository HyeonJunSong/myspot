import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myspot/models/category_and_keyword.dart';
import 'package:myspot/models/post.dart';
import 'package:myspot/services/keyword_location_search.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/post_page_view_controller.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/category_keyword_block.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class PostMapPage extends StatelessWidget {
  PostMapPage({Key? key}) : super(key: key);

  FocusNode textFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Obx( () => Scaffold(
      appBar: postMapPageAppbar(),
      resizeToAvoidBottomInset : false,
      body: Stack(
        children: [
          _map(),
          _searchBox(),
          _drawer()
        ],
      ),
    ));
  }

  _searchBox() => Positioned(
    top: 30.h,
    left: 27.w,
    width: 335.w,
    child: TextField(
      focusNode: textFocus,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: colorPrimary),
        ),
        contentPadding: EdgeInsets.fromLTRB(20.w, 14.h, 20.w, 14.h),
        hintText: "장소를 검색하세요",
        suffixIcon: GestureDetector(
          child: const Icon(Icons.search, size: 20,),
          onTap: () async {
            Get.find<PostPageViewController>().keyWordSearch();
            textFocus.unfocus();
          },
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      onChanged: (value){
        Get.find<PostPageViewController>().updateSearchKeyword(value);
      },
      onSubmitted: (value){
        Get.find<PostPageViewController>().keyWordSearch();
      },
    )
  );

  _map() => Positioned(
    child: NaverMap(
      initialCameraPosition: CameraPosition(
          target: LatLng(35.89229637317734, 128.60856585746507)
      ),
      markers: Get.find<PostPageViewController>()
          .searchResult()
          .map((e) => Marker(
          markerId: e.id,
          position: e.coor
      )).toList(),
      onMapCreated: Get.find<PostPageViewController>().onMapCreated,
    ),
  );

  _drawer() => Positioned(
    top: Get.find<PostPageViewController>().drawer_topSpace.value,
    child: Container(
      width: 390.w,
      height: 900.h,
      padding: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
          color: colorWhite
      ),
      child: Column(
        children: <Widget>[
          _knob(),
          Container(
            height: 844.h,
            child: SingleChildScrollView(
              child: Column(
                children: List<Widget>.from(Get.find<PostPageViewController>().searchResult.map(
                  (element) => _resultBlock(element)
                ).toList()),
              ),
            ),
          ),
        ]
      ),
    ),
  );

  _knob() => GestureDetector(
    onVerticalDragUpdate: (value){
      Get.find<PostPageViewController>().updateDrawerTopSpace(value.globalPosition.dy - 100.h);
    },
    child: Container(
      color: Colors.transparent,
      padding: EdgeInsets.all(10.h),
      child: Container(
        width: 50.w,
        height: 7.h,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        color: Colors.grey,
      ),
    ),
  );

  _resultBlock(LocationSearchResult result) => GestureDetector(
    onTap: (){
      Get.find<PostPageViewController>().updateCurCamPostion(result.coor);
    },
    child: Container(
      width: 390.w,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5),
            width: 1.h,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(result.placeName, style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp
              ),),
              SizedBox(height: 6.h,),
              Text(result.address, style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF737373),
                  fontSize: 14.sp
              ),),
            ],
          ),
          ElevatedButton(
            onPressed: (){
              Get.find<PostPageViewController>().updateLocation(result);
              Get.back();
            },
            child: Text("선택"),
          ),
        ],
      ),
    ),
  );
}