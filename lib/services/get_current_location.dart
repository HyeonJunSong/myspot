import 'package:geolocator/geolocator.dart';

Future<Position> getCurrentLocation() async {

  switch(await Geolocator.checkPermission()){
    case LocationPermission.denied:
    case LocationPermission.deniedForever:
    case LocationPermission.unableToDetermine:
      await Geolocator.requestPermission();
      break;

    case LocationPermission.whileInUse:
    case LocationPermission.always:
  }

  return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
}