import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart' as kakao;
import 'package:myspot/models/user.dart';
import 'package:myspot/services/kakao_login.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';
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
                    _title(),
                    SizedBox(height: 80.h),
                    Column(
                      children: [
                        _kakaoLoginButton(),
                        SizedBox(height: 7.h),
                        _emailSignInButton(),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 120.h),
                _emailSignUpButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _title() =>
  Text(
    'MySpot에서\n당신의 Spot을 풍요롭게,',
    style: TextStyle(
      fontSize: 26.sp,
      fontWeight: FontWeight.w700,
    ),
  );

Widget _kakaoLoginButton() => RoundedButton(
  onPressed: () {
    Get.find<SignUpInPageController>().userKakaoLogin().then(
          (value){
        if(value){
          Get.toNamed("/Main");
        }
      },
    );
  },
  btnColor: const Color(0xFFFEE500),
  textColor: const Color(0xFF191919),
  icon: Image.asset(
    'assets/images/kakao.png',
    width: 11.w,
  ),
  label: '카카오 로그인',
  width: 250.w,
);

// RoundedButton(
//   onPressed: () {},
//   icon: Image.asset(
//     'assets/images/google.png',
//     width: 11.w,
//   ),
//   label: 'Google 계정으로 로그인',
//   width: 250.w,
// ),

Widget _emailSignInButton() => RoundedButton(
  onPressed: () {
    Get.toNamed('/SignIn');
  },
  label: '이메일로 로그인',
  width: 250.w,
  // textColor: Colors.black,
  // btnColor: colorInactive,
);

Widget _emailSignUpButton() => RoundedButton(
  onPressed: () {
    Get.toNamed('/SignUp');
  },
  label: '이메일로 회원가입',
  width: 250.w,
  textColor: Colors.black,
  btnColor: Colors.white,
);