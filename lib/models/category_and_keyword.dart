
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

List<List<KeyWord>> keyWordList = [
  [
    KeyWord("🥘", "한식"),
    KeyWord("🍣", "일식"),
    KeyWord("🍝", "양식"),
    KeyWord("🥟", "중식"),
    KeyWord("🍜", "아시안"),
    KeyWord("🤑", "갓성비"),
    KeyWord("💕", "분위기"),
    KeyWord("🍚", "푸짐한")
  ],
  [
    KeyWord("✨", "분위기"),
    KeyWord("💸", "가성비"),
    KeyWord("✨", "친절"),
  ],
  [
    KeyWord("✨", "분위기"),
    KeyWord("💸", "가성비"),
    KeyWord("✨", "콘센트"),
    KeyWord("✨", "고양이"),
  ]
];

class CategorySelect{
  bool ifActivated;
  Category category;

  CategorySelect(this.ifActivated, this.category);
}

class KeyWordSelect{
  bool ifActivated;
  KeyWord keyWord;

  KeyWordSelect(this.ifActivated, this.keyWord);
}