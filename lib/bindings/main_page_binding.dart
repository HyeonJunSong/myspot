import 'package:get/get.dart';
import 'package:myspot/viewModels/city_view_controller.dart';

class MainPageBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(CityViewController());
  }
}