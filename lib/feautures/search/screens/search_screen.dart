import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../books/providers/book_provider.dart';
import '../../home/screens/widgets/book_card.dart';
import '../providers/search_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: 'Search books, authors, vendors...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.grey[400]),
          ),
          onChanged: (query) {
            final allBooks = context.read<BookProvider>().books;
            context.read<SearchProvider>().search(query, allBooks);
          },
        ),
        actions: [
          if (_searchController.text.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                _searchController.clear();
                context.read<SearchProvider>().search('', []);
              },
            ),
        ],
      ),
      body: Consumer<SearchProvider>(
        builder: (context, searchProvider, _) {
          if (searchProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (_searchController.text.isEmpty) {
            
            final recentSearches = searchProvider.recentSearches;
            if (recentSearches.isEmpty) {
              return Center(
                child: Text(
                  'Start searching for books, authors, or vendors',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Recent Searches',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          searchProvider.clearRecentSearches();
                        },
                        child: const Text('Clear All'),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: recentSearches.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.history),
                        title: Text(recentSearches[index]),
                        onTap: () {
                          _searchController.text = recentSearches[index];
                          final allBooks = context.read<BookProvider>().books;
                          searchProvider.search(recentSearches[index], allBooks);
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }

          final results = searchProvider.searchResults;
          if (results.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No results found',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.65,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: results.length,
            itemBuilder: (context, index) => BookCard(book: results[index]),
          );
        },
      ),
    );
  }
}