import 'package:flutter/material.dart';
import 'package:myspot/widgets/app_bar.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchResultPageAppbar(),
    );
  }
}
