import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/utils/constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/models/locations.dart';
import 'package:myspot/viewModels/city_view_controller.dart';

class dropDownSetLocationCity extends StatefulWidget {
  dropDownSetLocationCity({
    Key? key,
  }) : super(key: key);

  @override
  State<dropDownSetLocationCity> createState() => _dropDownSetLocationCityState();
}

class _dropDownSetLocationCityState extends State<dropDownSetLocationCity> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88.w,
      height: 37.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFD9D9D9),
          width: 2.w,
        ),
        borderRadius: BorderRadius.all(Radius.circular(20.w)),
      ),
      padding: EdgeInsets.fromLTRB(10.w, 0.h, 10.w, 0.h),
      child: Obx(() => DropdownButton<String>(
        value: Get.find<CityViewController>().city.value,
        icon: Image.asset("assets/images/down.png"),
//        elevation: 16,
        style: TextStyle(
          color: colorBlack,
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          overflow: TextOverflow.ellipsis,
        ),
        isExpanded: true,
        underline: const SizedBox(),

        onChanged: (String? newValue) {
          Get.find<CityViewController>().updateCity(newValue!);
        },

        items: Get.find<CityViewController>().cityList.keys
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )),
    );
  }
}
