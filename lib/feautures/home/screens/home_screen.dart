import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../books/providers/book_provider.dart';
import '../../books/screens/all_books/all_books_screen.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../../search/screens/search_screen.dart';
import '../../vendors/screens/all_vendors_screen.dart';
import '../../authors/screens/all_authors_screen.dart';
import 'widgets/section_header.dart';
import 'widgets/special_offer_card.dart';
import 'widgets/book_card.dart';
import 'widgets/vendor_card.dart';
import 'widgets/author_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Bar with Search and Notifications
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
                            // Navigate to search screen
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.notifications_outlined),
                          onPressed: () {
                            Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const NotificationsScreen()),
    );
                            // Navigate to notifications
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Special Offer Section
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final specialOfferBooks = bookProvider.specialOfferBooks;
                  if (specialOfferBooks.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: 'Special Offer',
                          buttonText: 'See all',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllBooksScreen(
                                  type: BooksListType.specialOffer,
                                  title: 'Special Offers',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: specialOfferBooks.length,
                          itemBuilder: (context, index) {
                            return SpecialOfferCard(
                              book: specialOfferBooks[index],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Top of Week Section
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final topWeekBooks = bookProvider.topOfWeekBooks;
                  if (topWeekBooks.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: 'Top of Week',
                          buttonText: 'See all',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllBooksScreen(
                                  type: BooksListType.topWeek,
                                  title: 'Top of Week',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 280,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: topWeekBooks.length,
                          itemBuilder: (context, index) {
                            return BookCard(
                              book: topWeekBooks[index],
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Best Vendors Section
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = bookProvider.books;
                  final vendors = books
                      .map((book) => {
                            'name': book.vendorName,
                            'image': book.vendorImage,
                          })
                      .toSet()
                      .toList();

                  if (vendors.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: 'Best Vendors',
                          buttonText: 'See all',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllVendorsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: vendors.length,
                          itemBuilder: (context, index) {
                            return VendorCard(
                              name: vendors[index]['name'] ?? '',
                              image: vendors[index]['image'] ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),

              // Authors Section
              Consumer<BookProvider>(
                builder: (context, bookProvider, _) {
                  final books = bookProvider.books;
                  final authors = books
                      .map((book) => {
                            'name': book.authorName,
                            'image': book.authorImage,
                          })
                      .toSet()
                      .toList();

                  if (authors.isEmpty) return const SizedBox.shrink();

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: SectionHeader(
                          title: 'Authors',
                          buttonText: 'See all',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AllAuthorsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: authors.length,
                          itemBuilder: (context, index) {
                            return AuthorCard(
                              name: authors[index]['name'] ?? '',
                              image: authors[index]['image'] ?? '',
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}