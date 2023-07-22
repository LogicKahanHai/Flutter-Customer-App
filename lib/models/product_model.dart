// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductModel {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final List<Map<String, String>> variants;
  final String selectedVariant;
  final double rating;
  bool isInCart;
  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.variants,
    required this.selectedVariant,
    required this.rating,
    this.isInCart = false,
  });
  

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    List<Map<String, String>>? variants,
    String? selectedVariant,
    double? rating,
    bool? isInCart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      variants: variants ?? this.variants,
      selectedVariant: selectedVariant ?? this.selectedVariant,
      rating: rating ?? this.rating,
      isInCart: isInCart ?? this.isInCart,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'variants': variants,
      'selectedVariant': selectedVariant,
      'rating': rating,
      'isInCart': isInCart,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      image: map['image'] as String,
      price: map['price'] as double,
      variants: List<Map<String, String>>.from(
        (map['variants'] as List<dynamic>).map<Map<String, String>>(
          (x) => x as Map<String, String>
        ),
      ) as List<Map<String, String>>,
      selectedVariant: map['selectedVariant'] as String,
      rating: map['rating'] as double,
      isInCart: map['isInCart'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
