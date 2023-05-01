import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/services/validator.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/viewModels/sign_up_in_controller.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar('회원가입'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 56.h, 36.h, 0.h),
        child: Form(
          key: Get.find<SignUpInPageController>().formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  _emailInputForm(),
                  _passwordInputForm(),
                  _userNameInputForm(),
                ],
              ),
              _submitButton(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _emailInputForm(){
  return InputForm(
    controller: Get.find<SignUpInPageController>().emailController,
    label: '이메일 주소',
    keyboardType: TextInputType.emailAddress,
    hint: '이메일 주소 입력',
    focusNode: Get.find<SignUpInPageController>().emailFocus,
    validator: (value) => CheckValidate
        .validateEmail(Get.find<SignUpInPageController>().emailFocus, value, Get.find<SignUpInPageController>().emailOverlapCheck),
    // onSaved: (newValue) => _newUser.email = newValue,
    onChanged: (newValue){
      Get.find<SignUpInPageController>().updateSignUpAvailable();
    },
    onSaved: (value){
      Get.find<SignUpInPageController>().checkValidation();
    },
    suffix: RoundedButton(
      onPressed: Get.find<SignUpInPageController>().emailController.value.text.isNotEmpty ? () async {
        //중복 확인
        switch(await Get.find<SignUpInPageController>().checkEmailExist()){
          case 200:
            Get.defaultDialog(
              radius: 10,
              title: "이메일 중복 여부",
              middleText: "사용 가능한 이메일입니다☺️",
            );
            break;
          default:
          //중복
            Get.defaultDialog(
              radius: 10,
              title: "이메일 중복 여부",
              middleText: "이미 사용중인 이메일이네요😅",
            );
            break;
        }
      } : null,
      label: '중복 확인',
      radius: 25.r,
      // width: 83.w,
      height: 30.h,
    ),
  );
}

Widget _passwordInputForm(){
  return InputForm(
    controller: Get.find<SignUpInPageController>().passwordController,
    label: '비밀번호',
    keyboardType: TextInputType.visiblePassword,
    hint: '영문 숫자 특수문자 포함 8~15자리 이내',
    focusNode: Get.find<SignUpInPageController>().passwordFocus,
    obscureText: Get.find<SignUpInPageController>().ifPasswordAvailable,
    validator: (value) =>
      CheckValidate.validatePassword(Get.find<SignUpInPageController>().passwordFocus, value),
    onChanged: (value){
      Get.find<SignUpInPageController>().updateSignUpAvailable();
    },
    // onSaved: (newValue) => _newUser.password = newValue,
    suffix: IconButton(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      constraints: const BoxConstraints(),
      icon: Icon(
        Get.find<SignUpInPageController>().passwordObscure.value
          ? Icons.visibility_off
          : Icons.visibility,
      ),
      onPressed: Get.find<SignUpInPageController>().passwordController.value.text.isNotEmpty
          ? () {
        Get.find<SignUpInPageController>().updatePassWordObsecure();
      }
          : null,
    ),
  );
}

Widget _userNameInputForm(){
  return InputForm(
    controller: Get.find<SignUpInPageController>().nicknameController,
    label: '닉네임',
    keyboardType: TextInputType.text,
    hint: '2자 이상',
    focusNode: Get.find<SignUpInPageController>().nicknameFocus,
    validator: (value) => CheckValidate.validateNickname(
        Get.find<SignUpInPageController>().nicknameFocus, value, Get.find<SignUpInPageController>().nickNameOverlapCheck),
    // onSaved: (newValue) => _newUser.nickname = newValue,
    onChanged: (value){
      print(Get.find<SignUpInPageController>().nicknameController.text);
      Get.find<SignUpInPageController>().updateSignUpAvailable();
    },
    suffix: RoundedButton(
      onPressed: Get.find<SignUpInPageController>().nicknameController.value.text.isNotEmpty
          ? () async {
        //중복 확인
        switch(await Get.find<SignUpInPageController>().checkNickNameExist()){
          case 200:
            Get.defaultDialog(
              radius: 10,
              title: "닉네임 중복 여부",
              middleText: "사용 가능한 닉네임입니다☺️",
            );
            break;
          default:
          //중복
            Get.defaultDialog(
              radius: 10,
              title: "이메일 중복 여부",
              middleText: "이미 사용중인 이메일이네요😅",
            );
            break;
        }
      }
          : null,
      label: '중복 확인',
      radius: 25.r,
      height: 30.h,
    ),
  );
}

Widget _submitButton(){
  return RoundedButton(
    onPressed: Get.find<SignUpInPageController>().ifSignUpAvailable.value
        ? () async {
      print("fuck!");
      switch(await Get.find<SignUpInPageController>().trySignUp()){
        case 200:
          debugPrint("회원가입 성공!!!");
          Get.defaultDialog(
            radius: 10,
            title: "회원가입",
            middleText: "회원가입 성공",
          );
          // 홈으로,,,,
          break;
        case 409:
          debugPrint("이미 존재하는 이메일입니다.");
          Get.defaultDialog(
            radius: 10,
            title: "회원가입",
            middleText: "이미 존재하는 이메일입니다.",
          );
          break;
        case 500:
          debugPrint("서버 오류");
          Get.defaultDialog(
            radius: 10,
            title: "회원가입",
            middleText: "서버 오류",
          );
          break;
        default:
          debugPrint("알 수 없는 오류");
          Get.defaultDialog(
            radius: 10,
            title: "회원가입",
            middleText: "알 수 없는 오류",
          );
          break;
      }
    }
    : null,
    label: '입력 완료!',
    width: 275.w,
  );
}