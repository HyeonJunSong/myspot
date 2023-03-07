import 'package:flutter/material.dart';

//ref) color: 0xAARRGGBB
const Color colorBlack = Color(0xFF000000);
const Color colorWhite = Color(0xFFFFFFFF);
const Color colorPrimary = Color(0xFF093386);
const Color colorKeyWordBlock = Color(0xFF009797);
const Color colorInactive = Color(0xFFDADADA);
const Color colorBackground = Color(0xFFFFFFFF);

Map<int, Color> materialPrimary = {
  50: Color.fromRGBO(9, 51, 134, .1),
  100: Color.fromRGBO(9, 51, 134, .2),
  200: Color.fromRGBO(9, 51, 134, .3),
  300: Color.fromRGBO(9, 51, 134, .4),
  400: Color.fromRGBO(9, 51, 134, .5),
  500: Color.fromRGBO(9, 51, 134, .6),
  600: Color.fromRGBO(9, 51, 134, .7),
  700: Color.fromRGBO(9, 51, 134, .8),
  800: Color.fromRGBO(9, 51, 134, .9),
  900: Color.fromRGBO(9, 51, 134, 1),
};

////////////////////////////////////////////////////////////////////////////////
const double drawer_bottom = 805;
const double drawer_mid = 485;
const double drawer_top = 165;

////////////////////////////////////////////////////////////////////////////////정렬기준
List<String> sortBy = [
  "거리 순",
  "스팟 순"
];