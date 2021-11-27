import 'package:demo_navigator_2/domain/book.dart';
import 'package:demo_navigator_2/domain/books.dart';
import 'package:flutter/material.dart';

class AppRouterState extends ChangeNotifier {
  int _selectedIndex;

  Book? _selectedBook;

  AppRouterState() : _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int idx) {
    _selectedIndex = idx;
    if (_selectedIndex == 1) {
      // Remove this line if you want to keep the selected book when navigating
      // between "settings" and "home" which book was selected when Settings is
      // tapped.
      selectedBook = null;
    }
    notifyListeners();
  }

  Book? get selectedBook => _selectedBook;

  set selectedBook(Book? book) {
    _selectedBook = book;
    notifyListeners();
  }

  int getSelectedBookById() {
    if (!books.contains(_selectedBook)) return 0;
    return books.indexOf(_selectedBook!);
  }

  void setSelectedBookById(int id) {
    if (id < 0 || id > books.length - 1) {
      return;
    }

    _selectedBook = books[id];
    notifyListeners();
  }
}
