import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class circleButton extends StatelessWidget {
  circleButton({
    Key? key,
    required this.diameter,
    required this.image,
  }) : super(key: key);

  double diameter;
  String image;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (){},
      child: Image.asset(
        image,
        width: diameter,
        height: diameter,
      ),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        shape: new RoundedRectangleBorder(
         borderRadius: new BorderRadius.circular(diameter / 2),
        ),
      ),
    );
  }
}
