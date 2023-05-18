import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/services/api.dart';
import 'package:myspot/services/coor_address_transition.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/models/locations.dart';
import 'package:myspot/viewModels/city_view_controller.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:myspot/widgets/drop_down_set_location_city.dart';
import 'package:myspot/widgets/drop_down_set_location_gu.dart';
import 'package:myspot/widgets/drop_down_set_location_dong.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class DialogLocationSetting extends StatelessWidget {
  const DialogLocationSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: colorBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.r)),
      ),
      insetPadding: EdgeInsets.all(0.w),
      child: SizedBox(
        width: 354.w,
        height: 221.h,
        child: Column(
          children: [
            _titleRow(),
            Divider(
              height: 0.h,
              thickness: 2,
              color: colorInactive,
            ),
            _bodyRow(),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////////////////////////title Row

Widget _titleRow(){
  return Container(
    height: 56.h,
    width: 354.w,
    padding: EdgeInsets.fromLTRB(20.w, 0.h, 20.w, 0.h),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _exitButton(),
        _title(),
        SizedBox( width: 15.w,),
      ]
    )
  );
}

_exitButton(){
  return GestureDetector(
    child: Container(
      width: 15.w,
      color: Colors.transparent,
      child: Image.asset(
        "assets/images/close.png",
        width: 9.33.w,
      ),
    ),
    onTap: () {
      Get.back(result: null);
    },
  );
}

_title(){
  return Text(
    "위치 설정",
    style: TextStyle(
      fontSize: 16.sp,
      fontWeight: FontWeight.w700,
    ),
  );
}

////////////////////////////////////////////////////////////////////////////////body Row
Widget _bodyRow(){
  return Container(
    height: 165.h,
    width: 354.w,
    padding: EdgeInsets.fromLTRB(26.w, 21.h, 26.w, 15.h),
    child: Container(
        width: 302.w,
        height: 129.h,
        child: Column(
          children: [
            _locationSetDropDownRow(),
            SizedBox( height: 9.h,),
            _detailedAddress(),
            SizedBox( height: 6.h,),
            //현재위치 & 완료
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 59.w,
                  height: 40.h,
                ),
                _toCurrentLocationButton(),
                _submitButton(),
              ],
            ),
          ],
        )),
  );
}

Widget _locationSetDropDownRow(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      dropDownSetLocationCity(),
      dropDownSetLocationGu(),
      dropDownSetLocationDong(),
    ],
  );
}

Widget _detailedAddress(){
  return Container(
    height: 37.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: const Color(0xFFD9D9D9),
        width: 2.w,
      ),
      borderRadius: BorderRadius.all(Radius.circular(20.w)),
    ),
    padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
    child: Center(
      child: TextFormField(
        cursorColor: colorBlack,
        textAlignVertical: TextAlignVertical.center,
        decoration: const InputDecoration.collapsed(
          hintText: "상세주소",
        ),
        style: TextStyle(
          color: colorBlack,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}

Widget _toCurrentLocationButton(){
  return GestureDetector(
    onTap: () async {
      NLatLng coor = await Get.find<UserController>().getPosition();
      Get.back(result: coor);
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/target.png",
          height: 16.h,
        ),
        SizedBox(width: 7.w),
        Text(
          "현재 위치로",
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    ),
  );
}

Widget _submitButton(){
  return Container(
    margin: EdgeInsets.fromLTRB(0, 8.h, 0, 0),
    width: 58.w,
    height: 32.h,
    decoration: BoxDecoration(
      border: Border.all(
        color: colorPrimary,
      ),
      borderRadius:
      BorderRadius.all(Radius.circular(10.r)),
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0.0,
        backgroundColor: colorPrimary,
      ),
      onPressed: () async {
        String _city = Get.find<CityViewController>().city.value;
        String _gu = Get.find<CityViewController>().gu.value;
        String _dong = Get.find<CityViewController>().dong.value;

        _city = _city == "선택없음" ? " " : _city;
        _gu = _gu == "선택없음" ? " " : _gu;
        _dong = _dong == "선택없음" ? " " : _dong;

        Get.find<UserController>().setAddress(
          CoorAndAddress(
            addressUpper: _city + ' ' + _gu,
            addressLower: _dong,
          ),
        );

        CoorAndAddress coor = await GETAddToCoorJSON(_city + _gu + _dong);

        Get.back(result: coor.coor);
      },
      child: Text(
        "완료",
        style: TextStyle(
          color: Colors.white,
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    ),
  );
}