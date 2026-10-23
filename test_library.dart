import 'library.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError('Тест не пройдено: $message');
}

void main() {
  final library = Library();
  check(library.findOldest() == null, 'порожня бібліотека');
  check(library.allDescriptions.isEmpty, 'порожній список описів');

  library.addItem(Book(title: 'Dart у дії', year: 2022, author: 'І. Петренко'));
  library.addItem(Magazine(title: 'Mobile Dev', year: 2023, issueNumber: 5));
  library.addItem(Book(title: 'Алгоритми', year: 2018, author: 'О. Шевченко'));

  check(library.items.length == 3, 'додавання елементів');
  check(library.findByYear(2022).length == 1, 'пошук за роком');
  check(library.findByYear(2000).isEmpty, 'пошук за відсутнім роком');
  check(library.findOldest()?.title == 'Алгоритми', 'найстаріше видання');
  check(library.allDescriptions.length == 3, 'кількість описів');
  check(library.allDescriptions[1].contains('випуск 5'), 'опис журналу');
  print('Усі тести завдання 1 пройдені.');
}
