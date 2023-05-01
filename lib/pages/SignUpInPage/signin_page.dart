import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  // @override
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      appBar: buildAppbar('로그인'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 80.h, 36.h, 0.h),
        child: Form(
          key: Get.find<SignUpInPageController>().formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _emailInputForm(),
              _passwordInputForm(),
              _submitButton(),
              _footer(),
            ],
          ),
        ),
      ),
    ));
  }
}

Widget _emailInputForm(){
  return InputForm(
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
  return InputForm(
    padding: EdgeInsets.only(bottom: 15.h),
    controller: Get.find<SignUpInPageController>().passwordController,
    keyboardType: TextInputType.visiblePassword,
    hint: '비밀번호 입력',
    focusNode: Get.find<SignUpInPageController>().passwordFocus,
    obscureText: Get.find<SignUpInPageController>().passwordObscure.value,
    // onSaved: (newValue) => _newUser.password = newValue,
    suffix: IconButton(
      //suffixicon으로 하면 위에 공간 없음 근데 아이콘이 계속 보여
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
      icon: Icon(
        Get.find<SignUpInPageController>().passwordObscure.value ? Icons.visibility_off : Icons.visibility,
        color: Colors.black54,
      ),
      onPressed: Get.find<SignUpInPageController>().passwordController.value.text.isNotEmpty
      ? () {
        Get.find<SignUpInPageController>().updatePassWordObsecure();
      }
          : null,
    ),
    onChanged: (value) {
      Get.find<SignUpInPageController>().ifSignInAvailableCheck();
    },
  );
}

Widget _submitButton(){
  return RoundedButton(
    onPressed:
    Get.find<SignUpInPageController>().ifSignInAvailable.value ? (){
      Get.find<SignUpInPageController>().trySignIn();
    } : null,
    label: '로그인',
    width: 275.w,
  );
}

Widget _footer(){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
    ),
  );
}