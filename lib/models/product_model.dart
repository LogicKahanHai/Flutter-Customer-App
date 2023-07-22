// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final double price;
  final List<Map<String, String>> variants;
  final int quantity;
  final bool isInCart;
  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.variants,
    required this.quantity,
    this.isInCart = false,
  });
  @override
  List<Object?> get props =>
      [name, description, image, price, quantity, variants, isInCart];

  ProductModel copyWith({
    String? id,
    String? name,
    String? description,
    String? image,
    double? price,
    List<Map<String, String>>? variants,
    int? quantity,
    bool? isInCart,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      isInCart: isInCart ?? this.isInCart,
      variants: variants ?? this.variants,
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
      'quantity': quantity,
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
          (x) => x,
        ),
      ),
      quantity: map['quantity'] as int,
      isInCart: map['isInCart'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
