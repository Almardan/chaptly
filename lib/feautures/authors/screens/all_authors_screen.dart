import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../books/providers/book_provider.dart';
import '../../home/screens/widgets/author_card.dart';

class AllAuthorsScreen extends StatelessWidget {
  const AllAuthorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authors'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          final books = bookProvider.books;
          final authors = books
              .map((book) => {
                    'name': book.authorName,
                    'image': book.authorImage,
                  })
              .toSet()
              .toList();

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: authors.length,
            itemBuilder: (context, index) {
              return AuthorCard(
                name: authors[index]['name'] ?? '',
                image: authors[index]['image'] ?? '',
              );
            },
          );
        },
      ),
    );
  }
}