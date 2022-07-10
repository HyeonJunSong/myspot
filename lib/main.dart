import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/pages/SignUpInPage/signin_page.dart';
import 'package:myspot/pages/SignUpInPage/signup_page.dart';
import 'package:myspot/pages/SignUpInPage/signupin_page.dart';
import 'package:myspot/utils/constants.dart';

void main() {
  runApp(const MySpotApp());
}

class MySpotApp extends StatelessWidget {
  const MySpotApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MySpot',
            initialRoute: "/Main",
            getPages: [
              // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
              //         () => Get.lazyPut<clientController>(() => clientController()))),
              GetPage(
                  name: "/Main",
                  page: () => const SignUpInPage(),
                  transition: Transition.fadeIn),
              GetPage(name: '/signupin', page: () => const SignUpInPage()),
              GetPage(name: '/signup', page: () => const SignUpPage()),
              GetPage(name: '/signin', page: () => const SignInPage()),
            ],
            theme: ThemeData(
              fontFamily: 'Noto_Sans_KR',
            ),
          );
        });
  }
}
