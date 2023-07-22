// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pk_customer_app/models/models.dart';

class CartModel {
  final List<ProductModel> products;
  const CartModel({
    required this.products,
  });

  CartModel copyWith({
    List<ProductModel>? products,
  }) {
    return CartModel(
      products: products ?? this.products,
    );
  }

  CartModel addToCart(ProductModel product) {
    return CartModel(
      products: [...products, product],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'products': products.map((x) => x.toMap()).toList(),
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    print('map[products]');
    try {
      return CartModel(
      products: List<ProductModel>.from(
          (map['products'] as List<dynamic>).map<ProductModel>(
            (x) => ProductModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      );
    } catch (e) {
      print(e);
      return CartModel(products: []);
    }
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
