import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/utils/constants.dart';

class InputForm extends StatefulWidget {
  const InputForm({
    Key? key,
    required this.controller,
    required this.keyboardType,
    this.label,
    this.hint,
    this.helper,
    this.focusNode,
    this.obscureText = false,
    this.validator,
    this.onSaved,
    this.suffix,
    this.padding,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final TextInputType keyboardType;
  final String? hint;
  final String? helper;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String?)? onSaved;
  final Widget? suffix;
  final EdgeInsetsGeometry? padding;

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.only(bottom: 25.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (widget.label != null)
              ? Text(widget.label!,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500))
              : Container(),
          (widget.label != null) ? SizedBox(height: 10.h) : Container(),
          TextFormField(
            // autovalidateMode: AutovalidateMode.onUserInteraction,  //실시간 유효성 검사
            controller: widget.controller,
            obscureText: widget.obscureText, //비밀번호 안보이게
            keyboardType: widget.keyboardType,
            decoration:
                _textFormDecoration(widget.hint, widget.helper, widget.suffix),
            focusNode: widget.focusNode,
            validator: widget.validator,
            onSaved: widget.onSaved,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }

  InputDecoration _textFormDecoration(hintText, helperText, suffix) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(width: 2.w, color: colorPrimary)),
      contentPadding: EdgeInsets.all(10.w),
      hintText: hintText,
      helperText: helperText,
      suffix: suffix,
    );
  }
}
