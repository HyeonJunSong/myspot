import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myspot/services/coor_to_address.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class UserController extends GetxController{

  //location
  Rx<LatLng> curPosition = LatLng(0, 0).obs;

  Future<void> getPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high).then((value) async {
      curPosition(LatLng(value.latitude, value.longitude));
      setAddress(await GETCoorToAddJSON(curPosition.value));
    });
  }

  //설정 된 주소
  RxString setAddressUpper = "".obs;
  RxString setAddressLower = "".obs;

  void setAddress(CoorToAdd newAddress){
    setAddressUpper(newAddress.addressUpper);
    setAddressLower(newAddress.addressLower);
  }



}