import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../home/screens/widgets/book_card.dart';
import '../../books/providers/book_provider.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../search/screens/search_screen.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Detective',
    'Romantic',
    'Action',
    'Thriller',
    'Fantasy',
    'Horror',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SearchScreen()),
        );          
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
    );            
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: _categories.map((category) => 
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: _selectedCategory == category,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                    selectedColor: AppColors.primary,
                    labelStyle: TextStyle(
                      color: _selectedCategory == category ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ).toList(),
            ),
          ),
          Expanded(
            child: Consumer<BookProvider>(
              builder: (context, bookProvider, _) {
                final books = _selectedCategory == 'All' 
                  ? bookProvider.books
                  : bookProvider.books.where((book) => 
                      book.category == _selectedCategory).toList();
                
                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    return BookCard(book: books[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}