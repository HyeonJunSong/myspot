import 'package:flutter/material.dart';
import 'package:myspot/widgets/app_bar.dart';

class SpotDetailPage extends StatelessWidget {
  const SpotDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar("스타벅스 경북대북문점"),
    );
  }
}
