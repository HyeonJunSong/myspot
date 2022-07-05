import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/pages/mainPage/mainPage.dart';

void main() {
  runApp(const MySpotApp());
}

class MySpotApp extends StatelessWidget {
  const MySpotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390,844),
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MySpot',
          initialRoute: "/Main",
          getPages: [
            // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
            //         () => Get.lazyPut<clientController>(() => clientController()))),
            GetPage(name: "/Main", page: () => mainPage(), transition: Transition.fadeIn),
          ],
        );
      }
    );
  }
}
