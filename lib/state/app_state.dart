import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/widgets/book_api.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  List<Books> _favorites = [];

  List<Books> get favorites => _favorites;

  void addFavorite(Books book) {
    if (!_favorites.contains(book)) {
      _favorites.add(book);
      notifyListeners(); // Cập nhật UI khi danh sách yêu thích thay đổi
    }
  }

  void removeFavorite(Books book) {
    if (_favorites.contains(book)) {
      _favorites.remove(book);
      notifyListeners(); // Cập nhật UI khi danh sách yêu thích thay đổi
    }
  }

  bool isFavorite(Books book) {
    return _favorites.contains(book); // Kiểm tra xem cuốn sách có phải là yêu thích không
  }
}
