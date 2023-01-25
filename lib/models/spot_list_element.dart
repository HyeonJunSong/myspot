import 'package:flutter/material.dart';
import 'package:naver_map_plugin/naver_map_plugin.dart';

class Spot{
  String place;
  int distance;
  String address;
  int likes;
  LatLng coor;
//  int id;

  Spot(
    this.place,
    this.distance,
    this.address,
    this.likes,
    this.coor
  );
}