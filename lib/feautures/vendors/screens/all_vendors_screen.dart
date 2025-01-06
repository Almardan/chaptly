import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../books/providers/book_provider.dart';
import '../../home/screens/widgets/vendor_card.dart';

class AllVendorsScreen extends StatelessWidget {
  const AllVendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Vendors'),
      ),
      body: Consumer<BookProvider>(
        builder: (context, bookProvider, _) {
          final books = bookProvider.books;
          final vendors = books
              .map((book) => {
                    'name': book.vendorName,
                    'image': book.vendorImage,
                  })
              .toSet()
              .toList();

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: vendors.length,
            itemBuilder: (context, index) {
              return VendorCard(
                name: vendors[index]['name'] ?? '',
                image: vendors[index]['image'] ?? '',
              );
            },
          );
        },
      ),
    );
  }
}