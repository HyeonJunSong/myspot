import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/services/kakao_login.dart';
import 'package:myspot/viewModels/user_controller.dart';

class SignUpInPageController extends GetxController{

  //////////////////////////////////////////////////////////////////////////////SignUpInPage
  Future<bool> userKakaoLogin() async{
    User user = await kakaoLogin();
    if(user.email == null){
      return false;
    }
    Get.find<UserController>().updateUser(user);
    return true;
  }

  //////////////////////////////////////////////////////////////////////////////SginUpPage
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool checkValidation(){
    return formKey.currentState!.validate();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode nicknameFocus = FocusNode();

  bool emailOverlapCheck = false;
  bool nickNameOverlapCheck = false;

  RxBool ifSignUpAvailable = false.obs;

  bool ifPasswordAvailable = true;
  void updatePasswordAvailable(){
    if(ifPasswordAvailable){
      ifPasswordAvailable = false;
    }
    else{
      ifPasswordAvailable = true;
    }
  }

  void updateSignUpAvailable(){
    if (emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        nicknameController.text.isNotEmpty) {
      ifSignUpAvailable(true);
    }
    else {
      ifSignUpAvailable(false);
    }
  }

  Future<int> checkEmailExist() async{
    int emailCheckResult = await User.checkEmail(emailController.value.text);
    if(emailCheckResult == 200) {
      emailOverlapCheck = false;
    }
    else{
      emailOverlapCheck = true;
    }
    return emailCheckResult;
  }

  Future<int> checkNickNameExist() async{
    int nicknameCheckResult = await User.checkNickname(nicknameController.value.text);
    if(nicknameCheckResult == 200) {
      emailOverlapCheck = false;
    }
    else{
      emailOverlapCheck = true;
    }
    return nicknameCheckResult;
  }

  Future<int> trySignUp() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // newUser.printProperties();
      //회원가입 시도

      int signUpResult = await User.signUp(
        email: emailController.text,
        password: passwordController.text,
        nickname: nicknameController.text,
        social: 0
      );

      return signUpResult;
    }
    else{
      return 0;
    }
  }

  RxBool passwordObscure = true.obs;
  void updatePassWordObsecure(){
    if(passwordObscure.value)
      passwordObscure(false);
    else
      passwordObscure(true);
  }

  RxBool ifSignInAvailable = false.obs;
  void ifSignInAvailableCheck(){
    emailController.text.isNotEmpty && passwordController.text.isNotEmpty
    ? ifSignInAvailable(true)
    : ifSignInAvailable(false);
  }

  Future<int> trySignIn() async {
    if (formKey.currentState!.validate()) {
      //로그인 형식 통과
      formKey.currentState!.save();
      //백으로 데이터 전송! 로그인 시도
      return await User.signIn(emailController.text, passwordController.text);
      // if (_apiResponse.apiError == null) {
      //   //로그인 성공시
      //   //사용자 정보 불러오기!!
      //   _apiResponse = await getUserDetails(_newUser.email!);
      //   _newUser = _apiResponse.data as User;
      //   Get.defaultDialog(
      //     radius: 10,
      //     title: "로그인",
      //     middleText: "${_newUser.nickname}님, 환영합니다. 🤩",
      //   );
      //   // 홈으로
      //   Future.delayed(const Duration(milliseconds: 500), () {
      //     Get.offAllNamed('/Main', arguments: _newUser);
      //   });
      // } else {
      //   Get.defaultDialog(
      //     radius: 10,
      //     title: "로그인",
      //     middleText: (_apiResponse.apiError as ApiError).error ?? "null",
      //   );
      // }
    }
    return 0;
  }
}