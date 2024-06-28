class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final String userId;
  final bool isAvailable;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    required this.imageUrl,
    required this.userId,
    required this.isAvailable,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'userId': userId,
      'isAvailable': isAvailable,
    };
  }

  factory Product.fromMap(String id, Map<String, dynamic> map) {
    return Product(
      id: id,
      name: map['name'] ?? "",
      description: map['description'] ?? "",
      price: map['price'] ?? "",
      category: map['category'] ?? "",
      imageUrl: map['imageUrl'] ?? "",
      userId: map['userId'] ?? "",
      isAvailable: map['isAvailable'] ?? false,
    );
  }

  Product copyWith({
    String? id,
    String? name,
    double? price,
    String? imageUrl,
    bool? isAvailable,
    int? quantity,
    String? category,
    String? description,
    String? userId,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      category: category ?? this.category,
      userId: userId ?? this.userId,
    );
  }
}
