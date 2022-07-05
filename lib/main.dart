import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
          initialRoute: "/LogIn",
          getPages: [
            // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
            //         () => Get.lazyPut<clientController>(() => clientController()))),
            GetPage(name: "/LogIn", page: () => LogInPage(), transition: Transition.fadeIn),
          ],
        );
      }
    );
  }
}
