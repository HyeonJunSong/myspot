import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myspot/services/coor_address_transition.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class UserController extends GetxController{

  //location
  Rx<LatLng> curPosition = LatLng(0, 0).obs;

  Future<LatLng> getPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position curPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    curPosition(LatLng(curPos.latitude, curPos.longitude));
    setAddress(await GETCoorToAddJSON(LatLng(curPos.latitude, curPos.longitude)));
    return LatLng(curPos.latitude, curPos.longitude);
  }

  //설정 된 주소
  RxString setAddressUpper = " ".obs;
  RxString setAddressLower = " ".obs;

  void setAddress(CoorAndAddress newAddress){
    setAddressUpper(newAddress.addressUpper);
    setAddressLower(newAddress.addressLower);
  }
}