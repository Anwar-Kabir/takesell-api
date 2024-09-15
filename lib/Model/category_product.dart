class Product {
  final int id;
  final String name;
  final String mainPrice;
  final String thumbnailImage;
  final int sales;

  Product({
    required this.id,
    required this.name,
    required this.mainPrice,
    required this.thumbnailImage,
    required this.sales,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      mainPrice: json['main_price'],
      thumbnailImage: json['thumbnail_image'],
      sales: json['sales'],
    );
  }
}
