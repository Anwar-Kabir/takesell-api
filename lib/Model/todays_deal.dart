class TodaysDeal {
  final int id;
  final String name;
  final String thumbnailImage;
  final bool hasDiscount;
  final String mainPrice;
  final String strokedPrice;
  final int sales;

  TodaysDeal({
    required this.id,
    required this.name,
    required this.thumbnailImage,
    required this.hasDiscount,
    required this.mainPrice,
    required this.strokedPrice,
    required this.sales,
  });

  factory TodaysDeal.fromJson(Map<String, dynamic> json) {
    return TodaysDeal(
      id: json['id'],
      name: json['name'],
      thumbnailImage: json['thumbnail_image'],
      hasDiscount: json['has_discount'],
      mainPrice: json['main_price'],
      strokedPrice: json['stroked_price'],
      sales: json['sales'],
    );
  }
}
