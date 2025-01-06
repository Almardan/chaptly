import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../models/book_model.dart';
import '../../providers/book_provider.dart';
import '../../../navigation/screens/main_navigation_screen.dart';
import 'widgets/image_picker_widget.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _bookNameController = TextEditingController();
  final _authorNameController = TextEditingController();
  final _vendorNameController = TextEditingController();
  final _priceController = TextEditingController();
  final List<String> _categories = [
    'Detective',
    'Romantic',
    'Action',
    'Thriller',
    'Fantasy',
    'Horror',
  ];
  String _selectedCategory = 'Detective';
  bool _isTopOfWeek = false;
  bool _isSpecialOffer = false;
  String? _bookImage;
  String? _authorImage;
  String? _vendorImage;

  @override
  void dispose() {
    _bookNameController.dispose();
    _authorNameController.dispose();
    _vendorNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  void _handleImagePicked(String type, String path) {
    setState(() {
      switch (type) {
        case 'book':
          _bookImage = path;
          break;
        case 'author':
          _authorImage = path;
          break;
        case 'vendor':
          _vendorImage = path;
          break;
      }
    });
  }

  void _handleSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      final book = BookModel(
        id: DateTime.now().toString(),
        bookName: _bookNameController.text,
        bookImage: _bookImage ?? '',
        authorName: _authorNameController.text,
        authorImage: _authorImage ?? '',
        vendorName: _vendorNameController.text,
        vendorImage: _vendorImage ?? '',
        category: _selectedCategory,
        price: double.tryParse(_priceController.text) ?? 0.0,
        isTopOfWeek: _isTopOfWeek,
        isSpecialOffer: _isSpecialOffer,
      );

      context.read<BookProvider>().addBook(book).then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                label: 'Book Name',
                controller: _bookNameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter book name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCategory,
                        isExpanded: true,
                        items: _categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ImagePickerWidget(
                label: 'Book Image',
                imagePath: _bookImage,
                onImagePicked: (path) => _handleImagePicked('book', path),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Author Name',
                controller: _authorNameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter author name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ImagePickerWidget(
                label: 'Author Image',
                imagePath: _authorImage,
                onImagePicked: (path) => _handleImagePicked('author', path),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Vendor Name',
                controller: _vendorNameController,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter vendor name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ImagePickerWidget(
                label: 'Vendor Image',
                imagePath: _vendorImage,
                onImagePicked: (path) => _handleImagePicked('vendor', path),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Price',
                controller: _priceController,
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return 'Please enter price';
                  }
                  if (double.tryParse(value!) == null) {
                    return 'Please enter valid price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Top of Week'),
                value: _isTopOfWeek,
                onChanged: (value) {
                  setState(() {
                    _isTopOfWeek = value ?? false;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Special Offer'),
                value: _isSpecialOffer,
                onChanged: (value) {
                  setState(() {
                    _isSpecialOffer = value ?? false;
                  });
                },
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: 'Save Book',
                onPressed: _handleSubmit,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,  // Profile tab
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index != 3) {
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