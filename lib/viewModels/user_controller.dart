import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/services/coor_address_transition.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class UserController extends GetxController{

  @override
  void onInit() {
    super.onInit();
    getPosition();
  }

  ////
  Rx<User> user = User(
    email: "test@google.com",
    nickname: "yanyanzzi",
  ).obs;
  String email = "test@google.com";

  void updateUser(User newUser){
    user(newUser);
  }

  ////location
  Rx<NLatLng> curPosition = NLatLng(0, 0).obs;

  Future<NLatLng> getPosition() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position curPos = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    curPosition(NLatLng(curPos.latitude, curPos.longitude));
    print(curPos);
    setAddress(await GETCoorToAddJSON(NLatLng(curPos.latitude, curPos.longitude)));
    return NLatLng(curPos.latitude, curPos.longitude);
  }

  ////설정 된 주소
  RxString setAddressUpper = " ".obs;
  RxString setAddressLower = " ".obs;

  void setAddress(CoorAndAddress newAddress){
    setAddressUpper(newAddress.addressUpper);
    setAddressLower(newAddress.addressLower);
  }
}