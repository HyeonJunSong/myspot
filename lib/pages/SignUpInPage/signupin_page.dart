import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/utils/constants.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'MySpot에서\n당신의 Spot을 풍요롭게,',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 80.h),
                  Column(
                    children: [
                      buildRoundedButoon(
                        () {},
                        Image.asset(
                          'assets/images/google.png',
                          width: 11.w,
                        ),
                        'Google 계정으로 로그인',
                        250.w,
                        Colors.white,
                        colorPrimary,
                      ),
                      SizedBox(height: 7.h),
                      buildRoundedButoon(
                        () {},
                        Container(),
                        '이메일로 로그인',
                        250.w,
                        Colors.black,
                        colorInactive,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20.h),
                child: buildRoundedButoon(
                  () {},
                  Container(),
                  '이메일로 로그인',
                  250.w,
                  Colors.black,
                  Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
