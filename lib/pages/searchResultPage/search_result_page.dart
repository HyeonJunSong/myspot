import 'package:flutter/material.dart';
import 'package:myspot/widgets/app_bar.dart';

class searchResultPage extends StatelessWidget {
  const searchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar("대학로80 주변 HotSpot"),

    );
  }
}
