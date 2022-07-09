import 'package:flutter/material.dart';


class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.diameter,
    required this.image,
  }) : super(key: key);

  final double diameter;
  final String image;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(diameter / 2),
        ),
      ),
      child: Image.asset(
        image,
        width: diameter,
        height: diameter,
      ),
    );
  }
}
