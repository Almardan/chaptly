import 'dart:io';
import 'package:chaptly/feautures/home/screens/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../books/providers/book_provider.dart';
import '../../navigation/screens/main_navigation_screen.dart';

class AuthorDetailScreen extends StatelessWidget {
  final String authorName;
  final String authorImage;

  const AuthorDetailScreen({
    super.key,
    required this.authorName,
    required this.authorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            // Author image
            if (authorImage.isNotEmpty) ...[
              ClipOval(
                child: Image.file(
                  File(authorImage),
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/png/default_user.png',
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ] else ...[
              Image.asset(
                'assets/png/default_user.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
            ],
            
            const SizedBox(height: 8),
            // Role 
            const Text(
              'Novelist',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            
            
            Text(
              authorName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            // Rating
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(4, (index) => 
                  const Icon(Icons.star, color: Colors.amber, size: 24)
                ),
                const Icon(Icons.star_half, color: Colors.amber, size: 24),
                const SizedBox(width: 8),
                const Text(
                  '(4.0)',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$authorName was born and raised in South Bend, Indiana. '
                    'She graduated from the University of Notre Dame with a Bachelor of Arts in '
                    'English and from New York University.',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Products',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Consumer<BookProvider>(
                    builder: (context, bookProvider, _) {
                      final authorBooks = bookProvider.books
                          .where((book) => book.authorName == authorName)
                          .toList();

                      return GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: authorBooks.length,
                        itemBuilder: (context, index) {
                          return BookCard(book: authorBooks[index]);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
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
                builder: (_) => const MainNavigationScreen(),
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