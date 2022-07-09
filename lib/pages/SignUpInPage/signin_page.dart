import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _submit() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //   _newUser.printProperties();
    //   //다음 페이지
    //   Get.toNamed('/signup2', id: 1);
    //}
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InputForm(
              padding: EdgeInsets.only(bottom: 15.h),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              hint: '이메일 주소 입력',
              // validator: (value) =>
              //       CheckValidate().validateEmail(_emailFocus, value, _emailCheck),
              // onSaved: (newValue) => _newUser.email = newValue,
              // To do: 중복확인
            ),
            InputForm(
              padding: EdgeInsets.only(bottom: 15.h),
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              hint: '비밀번호 입력',
              obscureText: true,
              // validator: (value) =>
              //       CheckValidate().validatePassword(_passwordFocus, value),
              //   onSaved: (newValue) => _newUser.password = newValue,
            ),
            roundedButoon(
              _isNotFormEmpty(_emailController, _passwordController)
                  ? () => _submit()
                  : null,
              Container(),
              '로그인',
              275.w,
              Colors.white,
              colorPrimary,
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '이메일 회원가입',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '이메일 찾기',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black45,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '비밀번호 찾기',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
