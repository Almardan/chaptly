class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? photoUrl;  
  bool isVerified;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.photoUrl,  
    this.isVerified = false,
  });

  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'photoUrl': photoUrl,
      'isVerified': isVerified,
    };
  }

  
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      photoUrl: map['photoUrl'],
      isVerified: map['isVerified'] ?? false,
    );
  }
}