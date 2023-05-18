import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:myspot/pages/SignUpInPage/signin_page.dart';
import 'package:myspot/pages/postMapPage/post_map_page.dart';
import 'package:myspot/pages/searchMapPage/search_map_page.dart';
import 'package:myspot/pages/searchPage/search_page.dart';
import 'package:myspot/pages/myPage/my_page.dart';
import 'package:myspot/pages/postPage/new_post_page.dart';
import 'package:myspot/pages/signUpInPage/signup_page.dart';
import 'package:myspot/pages/signUpInPage/signupin_page.dart';
import 'package:myspot/pages/mainPage/main_page.dart';
import 'package:myspot/utils/keyFiles.dart';
import 'package:myspot/pages/spotPage/spot_detail_page.dart';
import 'package:myspot/viewModels/city_view_controller.dart';
import 'package:myspot/viewModels/post_page_view_controller.dart';
import 'package:myspot/viewModels/search_page_view_controller.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'models/locations.dart';
import 'package:myspot/utils/constants.dart';


void main() async {
  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: kakaoLoginAPIKey,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk
      .instance
      .initialize(
        clientId: 'pgcr5t7242',
        onAuthFailed: (ex) {
          print("********* 네이버맵 인증오류 : $ex *********");
        },
  );
  
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
            initialRoute: "/SignUpIn",
            initialBinding: BindingsBuilder(() {
              Get.put(UserController());
              Get.put(CityViewController());
              Get.put(SignUpInPageController());
            }),
            getPages: [
              // GetPage(name: "/Load", page: () => LoadingPage(), transition: Transition.fadeIn, binding: BindingsBuilder(
              //         () => Get.lazyPut<clientController>(() => clientController()))),
              GetPage(
                name: "/Main",
                page: () {
                  getCityList();
                  return const MainPage();
                },
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/SignUpIn',
                page: () => const SignUpInPage(),
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/SignUp',
                page: () => const SignUpPage(),
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/SignIn',
                page: () => const SignInPage(),
                transition: Transition.noTransition,
              ),
              GetPage(
                name: '/Search',
                page: () => const SearchPage(),
                  binding: BindingsBuilder(() {
                    Get.put(SearchPageViewController());
                  })
              ),
              GetPage(
                name: '/SearchMap',
                page: () => const SearchMapPage(),
              ),
              GetPage(name: '/MyPage', page: () => const MyPage()),
              GetPage(
                name: '/NewPost',
                page: () => const NewPostPage(),
                binding: BindingsBuilder(() {
                  Get.put(PostPageViewController());
                }),
              ),
              GetPage(name: '/PostMap', page: () => PostMapPage(),),
              GetPage(name: '/SpotDetail', page: () => SpotDetailPage()),
            ],
          theme: ThemeData(
            fontFamily: 'Noto_Sans_KR',
            primaryColor: colorPrimary,
            primarySwatch: MaterialColor(0xFF093386, materialPrimary),
          ),
        );
      }
    );
  }
}
