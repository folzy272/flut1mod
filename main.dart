import 'dart:io';

import 'library.dart';

String readText(String prompt) {
  while (true) {
    stdout.write(prompt);
    final text = stdin.readLineSync();
    if (text == null) {
      print('\nВведення завершено.');
      exit(0);
    }
    if (text.trim().isNotEmpty) return text.trim();
    print('Поле не може бути порожнім.');
  }
}

int readPositiveInt(String prompt) {
  while (true) {
    final value = int.tryParse(readText(prompt));
    if (value != null && value > 0) return value;
    print('Введіть додатне ціле число.');
  }
}

void showItems(Iterable<LibraryItem> items) {
  final list = items.toList();
  if (list.isEmpty) {
    print('Видань не знайдено.');
    return;
  }
  for (final item in list) {
    print(item.describe());
  }
}

void main() {
  final library = Library();

  while (true) {
    print('\n========== БІБЛІОТЕКА ==========');
    print('1. Додати книгу');
    print('2. Додати журнал');
    print('3. Показати всі видання');
    print('4. Знайти видання за роком');
    print('5. Знайти найстаріше видання');
    print('0. Вихід');
    print('================================');

    switch (readText('Виберіть дію: ')) {
      case '1':
        final title = readText('Назва книги: ');
        final year = readPositiveInt('Рік видання: ');
        final author = readText('Автор: ');
        library.addItem(Book(title: title, year: year, author: author));
        print('Книгу додано.');
        break;
      case '2':
        final title = readText('Назва журналу: ');
        final year = readPositiveInt('Рік видання: ');
        final issueNumber = readPositiveInt('Номер випуску: ');
        library.addItem(Magazine(
          title: title,
          year: year,
          issueNumber: issueNumber,
        ));
        print('Журнал додано.');
        break;
      case '3':
        print('\nУсі видання:');
        // Використання геттера з вимог завдання.
        final descriptions = library.allDescriptions;
        if (descriptions.isEmpty) {
          print('Бібліотека порожня.');
        } else {
          for (final description in descriptions) {
            print(description);
          }
        }
        break;
      case '4':
        final year = readPositiveInt('Введіть рік пошуку: ');
        showItems(library.findByYear(year));
        break;
      case '5':
        final oldest = library.findOldest();
        print(oldest?.describe() ?? 'Бібліотека порожня.');
        break;
      case '0':
        print('Завершення програми.');
        return;
      default:
        print('Неправильний пункт меню. Спробуйте ще раз.');
    }
  }
}
