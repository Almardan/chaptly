import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/hive_boxes.dart';
import '../../notifications/providers/notification_provider.dart';
import '../models/book_model.dart';
import 'book_provider.dart';

class FavoriteProvider extends ChangeNotifier {
  final BuildContext context;
  List<BookModel> _favorites = [];
  bool _isLoading = false;

  FavoriteProvider(this.context);

  List<BookModel> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await Hive.openBox(HiveBoxes.favoriteBox);
    await _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(HiveBoxes.favoriteBox);
      final favoritesData = box.values.toList();
      
      
      final bookProvider = Provider.of<BookProvider>(context, listen: false);
      final allBooks = bookProvider.books;

      _favorites = favoritesData.map((data) {
        final favoriteBook = BookModel.fromMap(Map<String, dynamic>.from(data));
        
        final latestBook = allBooks.firstWhere(
          (book) => book.id == favoriteBook.id,
          orElse: () => favoriteBook,
        );
        // Return latest version but keep favorite status
        return latestBook.copyWith(isFavorite: true);
      }).toList();
      
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> toggleFavorite(BookModel book) async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(HiveBoxes.favoriteBox);
      final updatedBook = book.copyWith(isFavorite: !book.isFavorite);

      if (updatedBook.isFavorite) {
        await box.put(book.id, updatedBook.toMap());
        Provider.of<NotificationProvider>(context, listen: false)
            .addFavoriteNotification(book, true);
      } else {
        await box.delete(book.id);
        Provider.of<NotificationProvider>(context, listen: false)
            .addFavoriteNotification(book, false);
      }
      await _loadFavorites();
    } finally {
      _setLoading(false);
    }
  }

  // update favorites when a book is edited
  Future<void> refreshFavorites() async {
    await _loadFavorites();
  }

  bool isFavorite(String bookId) {
    return _favorites.any((book) => book.id == bookId);
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}