
class Category{
  String emoji;
  String categoryName;

  Category(this.emoji, this.categoryName);
}

class KeyWord{
  String emoji;
  String keyWordName;

  KeyWord(this.emoji, this.keyWordName);
}

List<Category> categoryList = [
  Category("🍽", "밥집"),
  Category("☕", "카페"),
  Category("🍺", "술집"),
];

List<KeyWord> keyWordList = [
  KeyWord("✨", "분위기"),
  KeyWord("💸", "가성비"),
];