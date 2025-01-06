class NotificationModel {
  final String id;
  final String title;
  final String message;
  final String? image;
  final DateTime dateTime;
  final String type; // 'favorite', 'delivery', etc.
  final String status; // 'current', 'delivered', 'cancelled', etc.
  final int? itemCount;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    this.image,
    required this.dateTime,
    required this.type,
    required this.status,
    this.itemCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'image': image,
      'dateTime': dateTime.toIso8601String(),
      'type': type,
      'status': status,
      'itemCount': itemCount,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      image: map['image'],
      dateTime: DateTime.parse(map['dateTime']),
      type: map['type'] ?? '',
      status: map['status'] ?? '',
      itemCount: map['itemCount'],
    );
  }
}