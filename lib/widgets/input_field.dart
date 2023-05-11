import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/utils/constants.dart';

Widget inputForm({
    required TextEditingController controller,
    required TextInputType keyboardType,
    String? label,
    String? hint,
    String? helper,
    FocusNode? focusNode,
    bool obscureText = false,
    String? Function(String?)? validator,
    Function(String?)? onSaved,
    Widget? suffix,
    Widget? suffixIcon,
    EdgeInsetsGeometry? padding,
    Function(String?)? onChanged,
  }){
  return Padding(
    padding: padding ?? EdgeInsets.only(bottom: 25.h),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (label != null)
            ? Text(label!,
                style:
                    TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))
            : Container(),
        (label != null) ? SizedBox(height: 10.h) : Container(),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,  //실시간 유효성 검사
          controller: controller,
          obscureText: obscureText, //비밀번호 안보이게
          keyboardType: keyboardType,
          decoration: _textFormDecoration(
              hint, suffix, suffixIcon),
          focusNode: focusNode,
          validator: validator,
          onSaved: onSaved,
          style: TextStyle(fontSize: 14.sp),
          cursorColor: colorPrimary,
          onChanged: onChanged,
        ),
      ],
    ),
  );
}

InputDecoration _textFormDecoration(hintText, suffix, suffxIcon) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(width: 2.w, color: colorPrimary)),
    contentPadding: EdgeInsets.all(8.w),
    hintText: hintText,
    errorStyle: TextStyle(fontSize: 11.sp),
    suffix: suffix,
    suffixIcon: suffxIcon,
  );
}