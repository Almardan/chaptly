class BookModel {
  final String id;
  final String bookName;
  final String bookImage;
  final String authorName;
  final String authorImage;
  final String vendorName;
  final String vendorImage;
  final String category;
  final double price;
  final bool isTopOfWeek;
  final bool isSpecialOffer;
  bool isFavorite; 

  BookModel({
    required this.id,
    required this.bookName,
    required this.bookImage,
    required this.authorName,
    required this.authorImage,
    required this.vendorName,
    required this.vendorImage,
    required this.category,
    required this.price,
    this.isTopOfWeek = false,
    this.isSpecialOffer = false,
    this.isFavorite = false, 
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookName': bookName,
      'bookImage': bookImage,
      'authorName': authorName,
      'authorImage': authorImage,
      'vendorName': vendorName,
      'vendorImage': vendorImage,
      'category': category,
      'price': price,
      'isTopOfWeek': isTopOfWeek,
      'isSpecialOffer': isSpecialOffer,
      'isFavorite': isFavorite, 
    };
  }

  factory BookModel.fromMap(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'] ?? '',
      bookName: map['bookName'] ?? '',
      bookImage: map['bookImage'] ?? '',
      authorName: map['authorName'] ?? '',
      authorImage: map['authorImage'] ?? '',
      vendorName: map['vendorName'] ?? '',
      vendorImage: map['vendorImage'] ?? '',
      category: map['category'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      isTopOfWeek: map['isTopOfWeek'] ?? false,
      isSpecialOffer: map['isSpecialOffer'] ?? false,
      isFavorite: map['isFavorite'] ?? false, // Add to fromMap
    );
  }

  
  BookModel copyWith({bool? isFavorite}) {
    return BookModel(
      id: id,
      bookName: bookName,
      bookImage: bookImage,
      authorName: authorName,
      authorImage: authorImage,
      vendorName: vendorName,
      vendorImage: vendorImage,
      category: category,
      price: price,
      isTopOfWeek: isTopOfWeek,
      isSpecialOffer: isSpecialOffer,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}