class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });

  // WantAPI field mapping:
  //   name        → title
  //   price       → price (string like "$999" stripped to double)
  //   tagline     → category
  //   description → description
  //   image       → image
  factory Product.fromJson(Map<String, dynamic> json) {
    final rawPrice = (json['price'] ?? '0').toString();
    final cleanPrice = double.tryParse(
          rawPrice.replaceAll(RegExp(r'[^\d.]'), ''),
        ) ??
        0.0;

    return Product(
      id: json['id'] ?? 0,
      title: json['name'] ?? '',
      price: cleanPrice,
      description: json['description'] ?? '',
      category: json['tagline'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
