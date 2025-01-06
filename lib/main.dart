import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'core/utils/go.dart';
import 'core/constants/app_colors.dart';
import 'core/constants/hive_boxes.dart';
import 'feautures/auth/providers/app_provider.dart';
import 'feautures/auth/providers/auth_provider.dart';
import 'feautures/books/providers/book_provider.dart';
import 'feautures/books/providers/favorite_provider.dart';
import 'feautures/search/providers/search_provider.dart';
import 'feautures/notifications/providers/notification_provider.dart';
import 'feautures/splash/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Hive.initFlutter();
  
  
  await Hive.openBox(HiveBoxes.userBox);
  await Hive.openBox(HiveBoxes.favoriteBox);
  await Hive.openBox(HiveBoxes.searchBox);
  await Hive.openBox(HiveBoxes.notificationBox);
  
 
  final authProvider = AuthProvider();
  final appProvider = AppProvider();
  final notificationProvider = NotificationProvider();
  final searchProvider = SearchProvider();
  
  
  await authProvider.init();
  await appProvider.init();
  await notificationProvider.init();
  await searchProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => appProvider),
        ChangeNotifierProvider(create: (_) => notificationProvider),
        ChangeNotifierProvider(create: (_) => searchProvider),
        
        ChangeNotifierProvider(
          create: (context) {
            final provider = BookProvider(context);
            provider.init();
            return provider;
          },
        ),
        
        ChangeNotifierProvider(
          create: (context) {
            final provider = FavoriteProvider(context);
            provider.init();
            return provider;
          },
        ),
      ],
      child: const BookStoreApp(),
    ),
  );
}

class BookStoreApp extends StatelessWidget {
  const BookStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Go.navigatorKey,
      title: 'Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}