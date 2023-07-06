import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';
import 'package:myspot/viewModels/user_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

import 'signUpInAppBar.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: signUpInAppBar('로그인'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 80.h, 36.h, 0.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _emailInputForm(),
            _passwordInputForm(),
            _submitButton(context),
            _footer(),
          ],
        ),
      ),
    ));
  }
}

Widget _emailInputForm(){
  return inputForm(
    padding: EdgeInsets.only(bottom: 15.h),
    controller: Get.find<SignUpInPageController>().emailController,
    keyboardType: TextInputType.emailAddress,
    hint: '이메일 주소 입력',
    focusNode: Get.find<SignUpInPageController>().emailFocus,
    // onSaved: (newValue) => _newUser.email = newValue,
    onChanged: (value) {
      Get.find<SignUpInPageController>().ifSignInAvailableCheck();
    },
  );
}

Widget _passwordInputForm(){
  return inputForm(
    padding: EdgeInsets.only(bottom: 15.h),
    controller: Get.find<SignUpInPageController>().passwordController,
    keyboardType: TextInputType.visiblePassword,
    hint: '비밀번호 입력',
    focusNode: Get.find<SignUpInPageController>().passwordFocus,
    obscureText: Get.find<SignUpInPageController>().ifPasswordHidden.value,
    // onSaved: (newValue) => _newUser.password = newValue,
    suffix: IconButton(
      //suffixicon으로 하면 위에 공간 없음 근데 아이콘이 계속 보여
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Get.find<SignUpInPageController>().ifPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
        color: Colors.black54,
        size: 16.h,
      ),
      onPressed: Get.find<SignUpInPageController>().passwordController.value.text.isNotEmpty
      ? () {
        Get.find<SignUpInPageController>().updateIfPasswordHidden();
      }
          : null,
    ),
    onChanged: (value) {
      Get.find<SignUpInPageController>().ifSignInAvailableCheck();
    },
  );
}

Widget _submitButton(BuildContext context){
  return RoundedButton(
    onPressed:
    Get.find<SignUpInPageController>().ifSignInAvailable.value ? (){
      FocusScope.of(context).unfocus();
      Get.find<SignUpInPageController>().trySignIn().then((value) {
        switch(value){
          case 200:
            Get.defaultDialog(
              radius: 10,
              title: "로그인",
              middleText: "${Get.find<UserController>().user.value.nickname}님, 환영합니다. 🤩",
            );
            // 홈으로
            Future.delayed(const Duration(milliseconds: 500), () {
              Get.offAllNamed('/Main');
            });
            break;
          default:
            Get.defaultDialog(
              radius: 10,
              title: "로그인 실패",
            );
        }

      });
    } : null,
    label: '로그인',
    width: 275.w,
  );
}

Widget _footer(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      TextButton(
        onPressed: () => Get.toNamed('/SignUp'),
        child: Text(
          '이메일 회원가입',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        '|',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          '이메일 찾기',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Text(
        '|',
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.black45,
          fontWeight: FontWeight.w500,
        ),
      ),
      TextButton(
        onPressed: () {},
        child: Text(
          '비밀번호 찾기',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ],
  );
}