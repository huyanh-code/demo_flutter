import 'dart:convert';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/widgets/book_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  List<Books> _favorites = [];

  List<Books> get favorites => _favorites;

  MyAppState() {
    _loadFavorites();
  }

  void addFavorite(Books book) {
    if (!_favorites.contains(book)) {
      _favorites.add(book);
      _saveFavorites();
      notifyListeners(); // Cập nhật UI khi danh sách yêu thích thay đổi
    }
  }

  void toggleFavorite(Books book) {
    if (_favorites.contains(book)) {
      _favorites.remove(book);
    } else {
      _favorites.add(book);
    }
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(Books book) {
    return _favorites.contains(book); // Kiểm tra xem cuốn sách có phải là yêu thích không
  }

  void _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favoriteBooks = prefs.getStringList('favorites') ?? [];
    _favorites = favoriteBooks.map((book) {
      final bookMap = jsonDecode(book);
      return Books.fromJson(bookMap);
    }).toList();
    notifyListeners();
  }

  void _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites.map((book) => jsonEncode(book.toJson())).toList());
  }

  void removeFavorite(Books book) {
    if (_favorites.any((b) => b.id == book.id)) {
      _favorites.removeWhere((b) => b.id == book.id);
      _saveFavorites();
      notifyListeners(); // Cập nhật UI khi danh sách yêu thích thay đổi
    }
  }
}
