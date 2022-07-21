import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:myspot/pages/signUpInPage/signin_page.dart';
import 'package:myspot/pages/signUpInPage/signup_page.dart';
import 'package:myspot/pages/signUpInPage/signupin_page.dart';
import 'package:myspot/pages/mainPage/main_page.dart';

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
                  page: () => const MainPage(),
                  transition: Transition.fadeIn),
              GetPage(name: '/SignUpIn', page: () => const SignUpInPage()),
              GetPage(name: '/SignUp', page: () => const SignUpPage()),
              GetPage(name: '/SignIn', page: () => const SignInPage()),
            ],
            theme: ThemeData(
              fontFamily: 'Noto_Sans_KR',
            ),
          );
        });
  }
}
