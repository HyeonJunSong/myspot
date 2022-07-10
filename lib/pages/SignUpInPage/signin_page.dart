import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/pages/SignUpInPage/validate.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool _passwordObscure = true;
  final _newUser = User();
  // late ApiResponse _apiResponse;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _newUser.printProperties();
      Get.snackbar('로그인', '로그인 성공 ~ 🥳');
      //백으로 데이터 전송!
      // _apiResponse =
      //     await authenticateUser(_newUser.email!, _newUser.password!);
      // if (_apiResponse.ApiError == null) {
      //   Get.snackbar('로그인', '로그인 성공 ~ 🥳');
      //   // 유저 데이터 불러와서,,,,
      //   // 홈으로,,,,
      //   //_saveAndRedirectToHome();
      // } else {
      //   Get.snackbar('오류', (_apiResponse.ApiError as ApiError).error);
      // }
    }
  }

  bool _isNotFormEmpty(
      TextEditingController email, TextEditingController password) {
    return email.value.text.isNotEmpty && password.value.text.isNotEmpty
        ? true
        : false;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.sp,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 12.h,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          '로그인',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 80.h, 36.h, 0.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InputForm(
                padding: EdgeInsets.only(bottom: 15.h),
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                hint: '이메일 주소 입력',
                focusNode: _emailFocus,
                validator: (value) =>
                    CheckValidate().validateEmail(_emailFocus, value, true),
                onSaved: (newValue) => _newUser.email = newValue,
              ),
              InputForm(
                padding: EdgeInsets.only(bottom: 15.h),
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                hint: '비밀번호 입력',
                focusNode: _passwordFocus,
                obscureText: _passwordObscure,
                validator: (value) =>
                    CheckValidate().validatePassword(_passwordFocus, value),
                onSaved: (newValue) => _newUser.password = newValue,
                suffixIcon: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: Icon(
                    _passwordObscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.black54,
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
              RoundedButton(
                onPressed:
                    _isNotFormEmpty(_emailController, _passwordController)
                        ? () => _submit()
                        : null,
                label: '로그인',
                width: 275.w,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () => Get.toNamed('/signup'),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
