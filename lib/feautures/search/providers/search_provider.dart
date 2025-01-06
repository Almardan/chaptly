import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../books/models/book_model.dart';

class SearchProvider extends ChangeNotifier {
  List<String> _recentSearches = [];
  List<BookModel> _searchResults = [];
  bool _isLoading = false;

  List<String> get recentSearches => _recentSearches;
  List<BookModel> get searchResults => _searchResults;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await Hive.openBox(HiveBoxes.searchBox);
    await _loadRecentSearches();
  }

  Future<void> _loadRecentSearches() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(HiveBoxes.searchBox);
      _recentSearches = box.get('recent_searches', defaultValue: <String>[]).cast<String>();
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addToRecentSearches(String query) async {
    if (query.trim().isEmpty) return;

    final box = await Hive.openBox(HiveBoxes.searchBox);
    _recentSearches = [query, ..._recentSearches.where((item) => item != query)]
      ..take(10)
      .toList();
    await box.put('recent_searches', _recentSearches);
    notifyListeners();
  }

  Future<void> clearRecentSearches() async {
    final box = await Hive.openBox(HiveBoxes.searchBox);
    await box.delete('recent_searches');
    _recentSearches = [];
    notifyListeners();
  }

  Future<void> search(String query, List<BookModel> allBooks) async {
    _setLoading(true);
    try {
      if (query.trim().isEmpty) {
        _searchResults = [];
      } else {
        final lowercaseQuery = query.toLowerCase();
        _searchResults = allBooks.where((book) {
          return book.bookName.toLowerCase().contains(lowercaseQuery) ||
              book.authorName.toLowerCase().contains(lowercaseQuery) ||
              book.vendorName.toLowerCase().contains(lowercaseQuery);
        }).toList();

        await addToRecentSearches(query);
      }
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}