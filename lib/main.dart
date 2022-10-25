import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myspot/bindings/main_page_binding.dart';
import 'package:myspot/pages/myPage/my_page.dart';
import 'package:myspot/pages/postPage/new_post_page.dart';
import 'package:myspot/pages/signUpInPage/signin_page.dart';
import 'package:myspot/pages/signUpInPage/signup_page.dart';
import 'package:myspot/pages/signUpInPage/signupin_page.dart';
import 'package:myspot/pages/mainPage/main_page.dart';
import 'package:myspot/pages/spotPage/spot_detail_page.dart';
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
            initialRoute: "/SignUp",
            getPages: [
              // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
              //         () => Get.lazyPut<clientController>(() => clientController()))),
              GetPage(
                name: "/Main",
                page: () => const MainPage(),
                binding: MainPageBinding(),
                transition: Transition.fadeIn,
              ),
              GetPage(name: '/SignUpIn', page: () => const SignUpInPage()),
              GetPage(name: '/SignUp', page: () => const SignUpPage()),
              GetPage(name: '/SignIn', page: () => const SignInPage()),
              GetPage(name: '/SpotDetail', page: () => const SpotDetailPage()),
              GetPage(name: '/MyPage', page: () => const MyPage()),
              GetPage(name: '/NewPost', page: () => const NewPostPage()),
            ],
            theme: ThemeData(
              fontFamily: 'Noto_Sans_KR',
              primaryColor: colorPrimary,
              primarySwatch: MaterialColor(0xFF093386, materialPrimary),
            ),
          );
        });
  }
}
