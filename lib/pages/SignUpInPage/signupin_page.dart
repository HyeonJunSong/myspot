import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:myspot/models/user.dart';
import 'package:myspot/services/kakao_login.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignUpInPage extends StatefulWidget {
  const SignUpInPage({Key? key}) : super(key: key);

  @override
  State<SignUpInPage> createState() => _SignUpInPageState();
}

class _SignUpInPageState extends State<SignUpInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(55.w, 260.h, 55.w, 0.h),
          child: SingleChildScrollView(
            //키보드로 인한 픽셀 오버플로우 방지
            child: Column(
              children: [
                Column(
                  children: [
                    Text(
                      'MySpot에서\n당신의 Spot을 풍요롭게,',
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 80.h),
                    Column(
                      children: [
                        RoundedButton(
                          onPressed: () {
                            kakaoLogin();
                          },
                          btnColor: const Color(0xFFFEE500),
                          textColor: const Color(0xFF191919),
                          icon: Image.asset(
                            'assets/images/kakao.png',
                            width: 11.w,
                          ),
                          label: '카카오 로그인',
                          width: 250.w,
                        ),
                        // RoundedButton(
                        //   onPressed: () {},
                        //   icon: Image.asset(
                        //     'assets/images/google.png',
                        //     width: 11.w,
                        //   ),
                        //   label: 'Google 계정으로 로그인',
                        //   width: 250.w,
                        // ),
                        SizedBox(height: 7.h),
                        RoundedButton(
                          onPressed: () {
                            Get.toNamed('/SignIn');
                          },
                          label: '이메일로 로그인',
                          width: 250.w,
                          // textColor: Colors.black,
                          // btnColor: colorInactive,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 120.h),
                RoundedButton(
                  onPressed: () {
                    Get.toNamed('/SignUp');
                  },
                  label: '이메일로 회원가입',
                  width: 250.w,
                  textColor: Colors.black,
                  btnColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Future kakaoLogin() async {
  // 카카오톡 실행 가능 여부 확인
  // 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await kakao.isKakaoTalkInstalled()) {
    try {
      await kakao.UserApi.instance.loginWithKakaoTalk();
      debugPrint('카카오톡으로 로그인 성공');
      //홈으로 이동
      User u = await getKakaoUser() as User;
      Get.toNamed('/Main', arguments: u);
    } catch (error) {
      debugPrint('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await kakao.UserApi.instance.loginWithKakaoAccount();
        debugPrint('카카오계정으로 로그인 성공');
        //홈으로 이동
        User u = await getKakaoUser() as User;
      Get.toNamed('/Main', arguments: u);
      } catch (error) {
        debugPrint('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await kakao.UserApi.instance.loginWithKakaoAccount();
      debugPrint('카카오계정으로 로그인 성공');
      //홈으로 이동
      User u = await getKakaoUser() as User;
      Get.toNamed('/Main', arguments: u);
    } catch (error) {
      debugPrint('카카오계정으로 로그인 실패 $error');
    }
  }
}
