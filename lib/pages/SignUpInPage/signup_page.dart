import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/services/validator.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/app_bar.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

import '../../services/api.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _nicknameFocus = FocusNode();

  bool _emailCheck = false; //true면 중복
  bool _nicknameCheck = false;
  bool _passwordObscure = true;
  final _newUser = User();
  late ApiResponse _apiResponse;

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _newUser.printProperties();
      //회원가입 시도
      _apiResponse = await signUp(
          _newUser.email!, _newUser.password!, _newUser.nickname!, 0);
      if (_apiResponse.apiError == null) {
        Get.defaultDialog(
          radius: 10,
          title: "회원가입",
          middleText: "회원가입이 성공되었습니다 ~ 🥳",
        );
        // 홈으로,,,,
        Get.back();
      } else {
        Get.defaultDialog(
          radius: 10,
          title: "회원가입",
          middleText: (_apiResponse.apiError as ApiError).toString(),
        );
      }
    }
  }

  bool _isNotFormEmpty(TextEditingController email,
      TextEditingController password, TextEditingController nickname) {
    return email.value.text.isNotEmpty &&
            password.value.text.isNotEmpty &&
            nickname.value.text.isNotEmpty
        ? true
        : false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar('회원가입'),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 56.h, 36.h, 0.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  InputForm(
                    controller: _emailController,
                    label: '이메일 주소',
                    keyboardType: TextInputType.emailAddress,
                    hint: '이메일 주소 입력',
                    focusNode: _emailFocus,
                    validator: (value) => CheckValidate()
                        .validateEmail(_emailFocus, value, _emailCheck),
                    onSaved: (newValue) => _newUser.email = newValue,
                    suffix: RoundedButton(
                      onPressed: _emailController.value.text.isNotEmpty
                          ? () async {
                              //중복 확인
                              _apiResponse =
                                  await checkEmail(_emailController.value.text);
                              if (_apiResponse.apiError == null) {
                                _emailCheck = false;
                                Get.defaultDialog(
                                  radius: 10,
                                  title: "이메일 중복 여부",
                                  middleText: _apiResponse.data.toString(),
                                );
                              } else {
                                //중복
                                _emailCheck = true;
                                Get.defaultDialog(
                                  radius: 10,
                                  title: "이메일 중복 여부",
                                  middleText:
                                      (_apiResponse.apiError as ApiError)
                                          .error!,
                                );
                              }
                            }
                          : null,
                      label: '중복 확인',
                      radius: 25.r,
                      // width: 83.w,
                      height: 30.h,
                    ),
                  ),
                  InputForm(
                    controller: _passwordController,
                    label: '비밀번호',
                    keyboardType: TextInputType.visiblePassword,
                    hint: '영문 숫자 특수문자 포함 8~15자리 이내',
                    focusNode: _passwordFocus,
                    obscureText: _passwordObscure,
                    validator: (value) =>
                        CheckValidate().validatePassword(_passwordFocus, value),
                    onSaved: (newValue) => _newUser.password = newValue,
                    suffix: IconButton(
                      padding: EdgeInsets.symmetric(vertical: 5.h),
                      constraints: const BoxConstraints(),
                      icon: Icon(
                        _passwordObscure
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: _passwordController.value.text.isNotEmpty
                          ? () {
                              setState(() {
                                _passwordObscure = !_passwordObscure;
                              });
                            }
                          : null,
                    ),
                  ),
                  InputForm(
                    controller: _nicknameController,
                    label: '닉네임',
                    keyboardType: TextInputType.text,
                    hint: '2자 이상',
                    focusNode: _nicknameFocus,
                    validator: (value) => CheckValidate().validateNickname(
                        _nicknameFocus, value, _nicknameCheck),
                    onSaved: (newValue) => _newUser.nickname = newValue,
                    // suffix: RoundedButton(
                    //   onPressed: _nicknameController.value.text.isNotEmpty
                    //       ? () async {
                    //           //중복 확인
                    //           _apiResponse = await checkNickname(_newUser.nickname!);
                    //           if (_apiResponse.ApiError == null) {
                    //             _nicknameCheck = true;
                    //           } else {
                    //             _nicknameCheck = false;
                    //             print(
                    //                 (_apiResponse.ApiError as ApiError).error);
                    //           }
                    //         }
                    //       : null,
                    //   label: '중복 확인',
                    //   radius: 25.r,
                    //   width: 83.w,
                    //   height: 30.h,
                    // ),
                  ),
                ],
              ),
              RoundedButton(
                onPressed: _isNotFormEmpty(_emailController,
                        _passwordController, _nicknameController)
                    ? () => _submit()
                    : null,
                label: '입력 완료!',
                width: 275.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
