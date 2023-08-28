// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pk_customer_app/models/models.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<String> gallery;
  final String selectedVariant;
  final double? rating;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.gallery,
    required this.selectedVariant,
    required this.rating,
  });

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.description == description &&
        other.image == image &&
        other.selectedVariant == selectedVariant &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        selectedVariant.hashCode ^
        rating.hashCode;
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    List<String>? gallery,
    List<VariantModel>? variants,
    String? selectedVariant,
    double? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      gallery: gallery ?? this.gallery,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      rating: rating ?? this.rating,
    );
  }

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String,
        name = json['name'] as String,
        description = json['description'] as String,
        image = json['featuredImg'] as String,
        gallery = (json['gallery'] as List<dynamic>).cast<String>(),
        selectedVariant =
            json['productVariantId'][0]["productVariantId"] as String,
        rating = double.tryParse(json['rating'] as String);

  Map<String, dynamic> toJson() => {
        'productId': id,
        'name': name,
        'description': description,
        'featuredImg': image,
        'gallery': gallery,
        'productVariantId': selectedVariant,
        'rating': rating,
      };
}
