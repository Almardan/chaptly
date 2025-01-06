import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/notification_model.dart';
import '../providers/notification_provider.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: Consumer<NotificationProvider>(
        builder: (context, notificationProvider, _) {
          if (notificationProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final notifications = notificationProvider.notifications;

          if (notifications.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'There is no notifications',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          // Group notifications by date
          final currentNotifications = notifications
              .where((n) => n.status == 'current')
              .toList();
          
          final pastNotifications = notifications
              .where((n) => n.status != 'current')
              .toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              if (currentNotifications.isNotEmpty) ...[
                const Text(
                  'Current',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...currentNotifications.map((notification) => _buildNotificationItem(notification)),
                const SizedBox(height: 24),
              ],
              if (pastNotifications.isNotEmpty) ...[
                const Text(
                  'October 2021',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...pastNotifications.map((notification) => _buildNotificationItem(notification)),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(NotificationModel notification) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: notification.image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.file(
                  File(notification.image!),
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 48,
                      height: 48,
                      color: Colors.grey[200],
                      child: Icon(Icons.book, color: Colors.grey[400]),
                    );
                  },
                ),
              )
            : null,
        title: Text(notification.title),
        subtitle: Row(
          children: [
            Text(
              notification.message,
              style: TextStyle(
                color: _getStatusColor(notification.status),
              ),
            ),
            if (notification.itemCount != null) ...[
              const SizedBox(width: 8),
              Text('${notification.itemCount} items'),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'current':
        return Colors.blue;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}