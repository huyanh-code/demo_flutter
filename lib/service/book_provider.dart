import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:namer_app/service/book_service.dart';
import 'package:namer_app/widgets/book_api.dart';

enum BookState {
  initial,
  loading,
  success,
  error,
}

class BookProvider with ChangeNotifier {
  final Logger logger = Logger((BookProvider).toString());

  final BookService _booksService = BookService();
  List<Books> _books = [];
  List<Books> _searchedBooks = [];

  List<Books> get books => _books;
  List<Books> get searchedBooks => _searchedBooks;

  BookState _state = BookState.initial;
  BookState get state => _state;

  String? _errorMessage = '';
  String? get errorMessage => _errorMessage;

  void _setState({required BookState newState, String? error = ''}) {
    logger.fine('State changed: '
        '{state: $_state, error: $_errorMessage}'
        ' => '
        '{state: $newState, error: $error}');

    _state = newState;
    _errorMessage = error;

    notifyListeners();
  }

  Future<void> fetchBooks() async {
    try {
      _setState(newState: BookState.loading);
      _books = await _booksService.getBooks();

      _setState(newState: BookState.success);
    } catch (e) {
      print('Error fetching books: $e');

      _setState(newState: BookState.error, error: 'Error occurs $e');
    }
  }

  Future<void> addBooks(Books books) async {
    try {
      final newBooks = await _booksService.createBooks(books);
      _books.add(newBooks);
      notifyListeners();
    } catch (e) {
      print('Error adding create, $e');
    }
  }

  Future<void> updateBooks(Books books) async {
    try {
      final updatedBooks = await _booksService.updateBooks(books);
      final index = _books.indexWhere((t) => t.id == updatedBooks.id);
      if (index != -1) {
        _books[index] = updatedBooks;
        notifyListeners();
      }
    } catch (e) {
      print('Error updating todo: $e');
    }
  }

  Future<void> deleteBooks(int id) async {
    try {
      await _booksService.deleteBooks(id);
      _books.removeWhere((todo) => todo.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting todo: $e');
    }
  }

   Future<void> searchBooks(String query) async {
    if (query.isEmpty) {
      // Nếu truy vấn trống, reset danh sách tìm kiếm
      _searchedBooks = [];
      notifyListeners();
      return;
    }

    try {
      _state = BookState.loading;
      notifyListeners();

      _searchedBooks = await _booksService.searchBooks(query);
      _state = BookState.success;
    } catch (e) {
      _state = BookState.error;
      _errorMessage = 'Lỗi tìm kiếm sách: $e';
    }
    notifyListeners();
  }
}
