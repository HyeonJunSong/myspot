import 'package:get/get.dart';
import 'package:myspot/models/category_and_mood.dart';

class SearchPageViewController extends GetxController{

//  RxList<category> categoryList = <category>[].obs;
  RxList<category> categoryList = <category>[
    category(true, "🍽", "밥집"),
    category(false, "☕", "카페"),
    category(false, "🍺", "술집"),
  ].obs;

  RxList<tag> moodList = <tag>[
    tag(true, "✨", "분위기"),
    tag(false, "💸", "가성비"),
  ].obs;

}