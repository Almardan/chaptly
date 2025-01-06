import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../models/book_model.dart';
import '../../providers/book_provider.dart';
import '../add_book/widgets/image_picker_widget.dart';

class EditBookScreen extends StatefulWidget {
  final BookModel book;

  const EditBookScreen({
    super.key,
    required this.book,
  });

  @override
  State<EditBookScreen> createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _bookNameController;
  late TextEditingController _authorNameController;
  late TextEditingController _vendorNameController;
  late TextEditingController _priceController;
  late String _selectedCategory;
  late bool _isTopOfWeek;
  late bool _isSpecialOffer;
  String? _bookImage;
  String? _authorImage;
  String? _vendorImage;

  final List<String> _categories = [
    'Detective',
    'Romantic',
    'Action',
    'Thriller',
    'Fantasy',
    'Horror',
  ];

  @override
  void initState() {
    super.initState();
    _bookNameController = TextEditingController(text: widget.book.bookName);
    _authorNameController = TextEditingController(text: widget.book.authorName);
    _vendorNameController = TextEditingController(text: widget.book.vendorName);
    _priceController = TextEditingController(text: widget.book.price.toString());
    _selectedCategory = widget.book.category;
    _isTopOfWeek = widget.book.isTopOfWeek;
    _isSpecialOffer = widget.book.isSpecialOffer;
    _bookImage = widget.book.bookImage;
    _authorImage = widget.book.authorImage;
    _vendorImage = widget.book.vendorImage;
  }

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
      final updatedBook = BookModel(
        id: widget.book.id,
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

      context.read<BookProvider>().updateBook(updatedBook).then((_) {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
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
                text: 'Save Changes',
                onPressed: _handleSubmit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}