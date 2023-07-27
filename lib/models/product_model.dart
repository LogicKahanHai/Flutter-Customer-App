// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/foundation.dart';

import 'package:pk_customer_app/models/models.dart';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final List<VariantModel> variants;
  final VariantModel selectedVariant;
  final double rating;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.variants,
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
        listEquals(other.variants, variants) &&
        other.selectedVariant == selectedVariant &&
        other.rating == rating;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        image.hashCode ^
        variants.hashCode ^
        selectedVariant.hashCode ^
        rating.hashCode;
  }
      

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    List<VariantModel>? variants,
    VariantModel? selectedVariant,
    double? rating,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      variants: variants ?? this.variants,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      rating: rating ?? this.rating,
    );
  }
}
