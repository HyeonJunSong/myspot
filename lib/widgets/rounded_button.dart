import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myspot/utils/constants.dart';

class RoundedButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? icon;
  final String? label;
  final double? width;
  final double? height;
  final double? radius;
  final Color? textColor;
  final Color? btnColor;

  const RoundedButton({
    required this.onPressed,
    this.icon,
    this.label,
    this.width,
    this.height,
    this.radius,
    this.textColor,
    this.btnColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 42.h,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon ?? Container(),
        label: Text(
          label ?? '',
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: btnColor ?? colorPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 10.r),
          ),
        ),
      ),
    );
  }
}
