import 'package:chaptly/feautures/favorites/screens/favorites_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../auth/providers/auth_provider.dart';
import '../../books/screens/add_book/add_book_screen.dart';
import '../../books/screens/manage_books/manage_books_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              // Header with user info and logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: const AssetImage('assets/png/default_user.png'),
                        backgroundColor: AppColors.primary,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        user?.name ?? 'User',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      context.read<AuthProvider>().signOut();
                    },
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              
              // Menu Items
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'My Account',
                onTap: () {
                  // Navigate to My Account
                },
              ),
              _buildMenuItem(
                icon: Icons.book_outlined,
                title: 'Add Books',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddBookScreen()),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.library_books_outlined,
                title: 'Manage Books',  // New menu item for managing books
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ManageBooksScreen()),
                  );
                },
              ),
              _buildMenuItem(
                icon: Icons.location_on,
                title: 'Address',
                onTap: () {
                  // Navigate to Address
                },
              ),
              _buildMenuItem(
                icon: Icons.local_offer_outlined,
                title: 'Offers & Promos',
                onTap: () {
                  // Navigate to Offers
                },
              ),
              _buildMenuItem(
                icon: Icons.favorite_outline,
                title: 'Your Favorites',
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  );
                  // Navigate to Favorites
                },
              ),
              _buildMenuItem(
                icon: Icons.history,
                title: 'Order History',
                onTap: () {
                  // Navigate to Order History
                },
              ),
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  // Navigate to Help Center
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: AppColors.primary,
      ),
      title: Text(title),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}