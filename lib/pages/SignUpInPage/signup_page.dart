import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/utils/constants.dart';
import 'package:myspot/widgets/input_field.dart';
import 'package:myspot/widgets/rounded_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nicknameController = TextEditingController();

  void _submit() {
    // if (_formKey.currentState!.validate()) {
    //   _formKey.currentState!.save();
    //   _newUser.printProperties();
    //   //다음 페이지
    //   Get.toNamed('/signup2', id: 1);
    //}
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
          '회원가입',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(36.w, 56.h, 36.h, 300.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                InputForm(
                  controller: _emailController,
                  label: '이메일 주소',
                  keyboardType: TextInputType.emailAddress,
                  hint: '이메일 주소 입력',
                ),
                InputForm(
                  controller: _passwordController,
                  label: '비밀번호',
                  keyboardType: TextInputType.emailAddress,
                  hint: '영문 숫자 특수문자 포함 8자리 이상',
                ),
                InputForm(
                  controller: _nicknameController,
                  label: '닉네임',
                  keyboardType: TextInputType.emailAddress,
                  hint: '2자 이상',
                ),
              ],
            ),
            roundedButoon(
              _isNotFormEmpty(_emailController, _passwordController,
                      _nicknameController)
                  ? () => _submit()
                  : null,
              Container(),
              '입력 완료!',
              275.w,
              Colors.white,
              colorPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
