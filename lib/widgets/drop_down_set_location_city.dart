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
  String dropdownValue = "";
  @override
  void initState() {
    super.initState();
    dropdownValue = Get.find<CityViewController>().city[0];
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
        value: dropdownValue,
        icon: Image.asset("assets/images/down.png"),
//        elevation: 16,
        style: TextStyle(
          color: colorBlack,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
        isExpanded: true,
        underline: const SizedBox(),

        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
          updateGu(locations_city.code[locations_city.name.indexOf(dropdownValue)]);
        },

        items: Get.find<CityViewController>().city.value
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
