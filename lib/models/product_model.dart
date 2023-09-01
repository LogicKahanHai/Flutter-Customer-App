// ignore_for_file: public_member_api_docs, sort_constructors_first

class ProductModel {
  final String id;
  final int productId;
  final String name;
  final String description;
  final String image;
  final List<String> gallery;
  final int selectedVariant;
  final double? rating;
  ProductModel({
    required this.id,
    required this.productId,
    required this.name,
    required this.description,
    required this.image,
    required this.gallery,
    required this.selectedVariant,
    required this.rating,
  });

  ProductModel copyWith({
    String? id,
    int? productId,
    String? name,
    String? description,
    String? image,
    List<String>? gallery,
    int? selectedVariant,
    double? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      gallery: gallery ?? this.gallery,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      rating: rating ?? this.rating,
    );
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.selectedVariant == selectedVariant &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        selectedVariant.hashCode ^
        rating.hashCode;
  }

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String,
        productId = json['productId'] as int? ?? 0,
        name = json['name'] as String,
        description = json['description'] as String,
        image = json['featuredImg'] as String,
        gallery = (json['gallery'] as List<dynamic>).cast<String>(),
        selectedVariant =
            json['productVariantId']?[0]["productVariantId"] as int? ?? 0,
        rating = double.tryParse(json['rating'] as String? ?? '0.0');

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'description': description,
        'featuredImg': image,
        'gallery': gallery,
        'productVariantId': selectedVariant,
        'rating': rating,
      };
}
