class CategoryModel {
  final String id;
  final String title;
  final String featuredImg;
  final String description;
  final String thumbImg;

  CategoryModel({
    required this.id,
    required this.title,
    required this.featuredImg,
    required this.description,
    required this.thumbImg,
  });

  CategoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        title = json['title'],
        featuredImg = json['featuredImg'],
        description = json['description'],
        thumbImg = json['thumbImg'];

  Map<String, dynamic> toJson() => {
        '_id': id,
        'title': title,
        'featuredImg': featuredImg,
        'description': description,
        'thumbImg': thumbImg,
      };
}
