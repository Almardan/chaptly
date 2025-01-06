import 'package:flutter/material.dart';

class Go {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static BuildContext get context => navigatorKey.currentContext!;

  static Future<T?> to<T>(Widget page) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> replace<T>(Widget page) async {
    return await Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static Future<T?> off<T>(Widget page) async {
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }

  static void back<T>([T? result]) {
    return Navigator.pop(context, result);
  }
}