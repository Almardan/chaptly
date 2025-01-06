import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/constants/hive_boxes.dart';
import '../models/notification_model.dart';
import '../../books/models/book_model.dart';

class NotificationProvider extends ChangeNotifier {
  List<NotificationModel> _notifications = [];
  bool _isLoading = false;

  List<NotificationModel> get notifications => _notifications;
  bool get isLoading => _isLoading;

  Future<void> init() async {
    await Hive.openBox(HiveBoxes.notificationBox);
    await _loadNotifications();
  }

  Future<void> _loadNotifications() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(HiveBoxes.notificationBox);
      final notificationsData = box.values.toList();
      _notifications = notificationsData
          .map((data) => NotificationModel.fromMap(Map<String, dynamic>.from(data)))
          .toList();
      _notifications.sort((a, b) => b.dateTime.compareTo(a.dateTime));
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addFavoriteNotification(BookModel book, bool added) async {
    final notification = NotificationModel(
      id: DateTime.now().toString(),
      title: book.bookName,
      message: added ? 'Added to favorites' : 'Removed from favorites',
      image: book.bookImage,
      dateTime: DateTime.now(),
      type: 'favorite',
      status: 'current',
    );

    final box = await Hive.openBox(HiveBoxes.notificationBox);
    await box.put(notification.id, notification.toMap());
    await _loadNotifications();
  }

  Future<void> clearAllNotifications() async {
    _setLoading(true);
    try {
      final box = await Hive.openBox(HiveBoxes.notificationBox);
      await box.clear();
      _notifications = [];
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