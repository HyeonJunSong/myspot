import 'package:flutter/material.dart';


class CircleButton extends StatelessWidget {
  const CircleButton({
    Key? key,
    required this.diameter,
    required this.image,
    required this.color,
  }) : super(key: key);

  final double diameter;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(diameter / 2),
        ),
        shadowColor: Colors.transparent
      ),
      child: Image.asset(
        image,
        width: diameter,
        height: diameter,
      ),
    );
  }
}
