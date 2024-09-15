class FeaturedCategory {
  final int id;
  final String name;
  final String banner;
  final int numberOfChildren;

  FeaturedCategory(
      {required this.id,
      required this.name,
      required this.banner,
      required this.numberOfChildren});

  factory FeaturedCategory.fromJson(Map<String, dynamic> json) {
    return FeaturedCategory(
      id: json['id'],
      name: json['name'],
      banner: json['banner'],
      numberOfChildren: json['number_of_children'],
    );
  }
}
