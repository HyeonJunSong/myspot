import 'dart:math';
import 'package:naver_map_plugin/naver_map_plugin.dart';

int distanceInMBetweenEarthCoordinates(LatLng coor1, LatLng coor2) {
  const earthRadiusKm = 6371;

  var dLat = _degreesToRadians(coor2.latitude-coor1.latitude);
  var dLon = _degreesToRadians(coor2.longitude-coor1.longitude);

  var lat1 = _degreesToRadians(coor1.latitude);
  var lat2 = _degreesToRadians(coor2.latitude);

  var a = sin(dLat/2) * sin(dLat/2) +
      sin(dLon/2) * sin(dLon/2) * cos(lat1) * cos(lat2);
  var c = 2 * atan2(sqrt(a), sqrt(1-a));
  return (earthRadiusKm * c * 1000).toInt();
}

double _degreesToRadians(degrees) {
  return degrees * pi / 180;
}