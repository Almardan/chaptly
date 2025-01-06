import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../models/book_model.dart';
import 'favorite_provider.dart';

class BookProvider extends ChangeNotifier {
  final BuildContext context;  
  static const String _bookBoxName = 'bookBox';
  List<BookModel> _books = [];
  bool _isLoading = false;

  BookProvider(this.context);  
  List<BookModel> get books => _books;
  List<BookModel> get topOfWeekBooks => _books.where((book) => book.isTopOfWeek).toList();
  List<BookModel> get specialOfferBooks => _books.where((book) => book.isSpecialOffer).toList();
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await Hive.openBox(_bookBoxName);
    await _loadBooks();
  }

  Future<void> _loadBooks() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(_bookBoxName);
      final booksData = box.values.toList();
      _books = booksData.map((data) => BookModel.fromMap(Map<String, dynamic>.from(data))).toList();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addBook(BookModel book) async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(_bookBoxName);
      await box.put(book.id, book.toMap());
      await _loadBooks();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateBook(BookModel book) async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(_bookBoxName);
      await box.put(book.id, book.toMap());
      await _loadBooks();
      
      // Refresh favorites after updating book
      if (context.mounted) {
        Provider.of<FavoriteProvider>(context, listen: false).refreshFavorites();
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> deleteBook(String id) async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(_bookBoxName);
      await box.delete(id);
      await _loadBooks();

      // Refresh favorites after deleting book
      if (context.mounted) {
        Provider.of<FavoriteProvider>(context, listen: false).refreshFavorites();
      }
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}