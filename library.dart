abstract class LibraryItem {
  final String title;
  final int year;

  LibraryItem({required this.title, required this.year});

  String describe();
}

class Book extends LibraryItem {
  final String author;

  Book({
    required super.title,
    required super.year,
    required this.author,
  });

  @override
  String describe() => 'Книга: $title ($year) — $author';
}

class Magazine extends LibraryItem {
  final int issueNumber;

  Magazine({
    required super.title,
    required super.year,
    required this.issueNumber,
  });

  @override
  String describe() => 'Журнал: $title ($year), випуск $issueNumber';
}

class Library {
  final List<LibraryItem> items = [];

  void addItem(LibraryItem item) {
    items.add(item);
  }

  List<LibraryItem> findByYear(int year) {
    return items.where((item) => item.year == year).toList();
  }

  List<String> get allDescriptions {
    return items.map((item) => item.describe()).toList();
  }

  LibraryItem? findOldest() {
    if (items.isEmpty) return null;

    var oldest = items.first;
    for (final item in items.skip(1)) {
      if (item.year < oldest.year) oldest = item;
    }
    return oldest;
  }
}
