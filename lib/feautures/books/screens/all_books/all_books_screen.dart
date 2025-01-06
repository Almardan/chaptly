import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../navigation/screens/main_navigation_screen.dart';
import '../../providers/book_provider.dart';
import '../../../home/screens/widgets/book_card.dart';

enum BooksListType { 
  topWeek, 
  allBooks,
  specialOffer  
}

class AllBooksScreen extends StatelessWidget {
  final BooksListType type;
  final String title;

  const AllBooksScreen({
    super.key,
    required this.type,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          final books = switch (type) {
            BooksListType.topWeek => bookProvider.topOfWeekBooks,
            BooksListType.specialOffer => bookProvider.specialOfferBooks,
            _ => bookProvider.books,
          };

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return BookCard(
                book: books[index],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => MainNavigationScreen(initialIndex: index),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}