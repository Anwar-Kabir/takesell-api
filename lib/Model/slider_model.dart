class SliderModel {
  final String? photo;

  SliderModel({this.photo});

  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(photo: json['photo']);
  }
}
