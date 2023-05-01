import 'package:flutter/material.dart';

class CheckValidate {
  static String? validateEmail(FocusNode focusNode, String? value, bool check) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      focusNode.requestFocus();
      return '• 이메일을 입력해주세요.';
    } else if (!regExp.hasMatch(value)) {
      focusNode.requestFocus(); //포커스를 해당 textformfield에 맞춘다.
      return '• 잘못된 이메일 형식입니다.';
    } else if (check == true) {
      focusNode.requestFocus();
      return '• 이미 사용중인 이메일입니다.';
    }
    return null;
  }

  static String? validatePassword(FocusNode focusNode, String? value) {
    String pattern =
        r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?~^<>,.&+=])[A-Za-z\d$@$!%*#?~^<>,.&+=]{8,15}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      focusNode.requestFocus();
      return '• 특수문자, 대소문자, 숫자 포함 8~15자 이내로 입력해주세요.';
    } else if (value.length < 8) {
      return '• 아직 8자 미만이에요.';
    } else if (value.length > 15) {
      return '• 15자를 초과했어요.';
    } else if (!regExp.hasMatch(value)) {
      return '• 특수문자, 대소문자, 숫자 포함 8~15자 이내로 입력해주세요.';
    }
    return null;
  }

  static String? validateNickname(FocusNode focusNode, String? value, bool check) {
    String pattern = r'^[ㄱ-ㅎ|ㅏ-ㅣ|가-힣0-9a-z]{2,6}$';
    RegExp regExp = RegExp(pattern);
    if (value == null || value.isEmpty) {
      focusNode.requestFocus();
      return '• 특수문자 제외 2~20자 이내로 입력해주세요.';
    } else if (!regExp.hasMatch(value)) {
      focusNode.requestFocus(); //포커스를 해당 textformfield에 맞춘다.
      return '• 특수문자 제외 2~20자 이내로 입력해주세요.';
    } else if (check == true) {
      focusNode.requestFocus();
      return '• 이미 사용중인 닉네임입니다!';
    }
    return null;
  }
}
