import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:myspot/models/user.dart';
import 'package:myspot/services/api.dart';
import 'package:myspot/widgets/app_bar.dart';
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
  late var _newUser = User();
  late ApiResponse _apiResponse;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      //로그인 형식 통과
      _formKey.currentState!.save();
      //백으로 데이터 전송! 로그인 시도
      _apiResponse = await signIn(_newUser.email!, _newUser.password!);
      if (_apiResponse.apiError == null) {
        //로그인 성공시
        //사용자 정보 불러오기!!
        _apiResponse = await getUserDetails(_newUser.email!);
        _newUser = _apiResponse.data as User;
        Get.defaultDialog(
          radius: 10,
          title: "로그인",
          middleText: "${_newUser.nickname}님, 환영합니다. 🤩",
        );
        // 홈으로
        Get.toNamed("/Main");
      } else {
        Get.defaultDialog(
          radius: 10,
          title: "로그인",
          middleText: (_apiResponse.apiError as ApiError).error ?? "null",
        );
      }
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
      appBar: buildAppbar('로그인'),
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
                onSaved: (newValue) => _newUser.email = newValue,
              ),
              InputForm(
                padding: EdgeInsets.only(bottom: 15.h),
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                hint: '비밀번호 입력',
                focusNode: _passwordFocus,
                obscureText: _passwordObscure,
                onSaved: (newValue) => _newUser.password = newValue,
                suffix: IconButton(
                  //suffixicon으로 하면 위에 공간 없음 근데 아이콘이 계속 보여
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
