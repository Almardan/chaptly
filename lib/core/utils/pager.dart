import 'package:flutter/material.dart';

class Pager {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static Future<T?> push<T>(BuildContext context, Widget page) async {
    return await Navigator.push<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushReplacement<T>(BuildContext context, Widget page) async {
    return await Navigator.pushReplacement<T, dynamic>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?> pushAndRemoveUntil<T>(BuildContext context, Widget page) async {
    return await Navigator.pushAndRemoveUntil<T>(
      context,
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.pop(context, result);
  }
}