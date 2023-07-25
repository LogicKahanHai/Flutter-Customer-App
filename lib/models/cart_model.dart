// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:pk_customer_app/models/models.dart';

class CartModel {
  final List<ProductModel> products;
  const CartModel({
    this.products = const [],
  });

  CartModel.fromJson(String source)
      : products = List<ProductModel>.from(
          json.decode(source)['products']?.map(
                (x) => ProductModel.fromJson(x as Map<String, dynamic>),
              ) as Iterable<dynamic>,
        );

  Map<String, dynamic> toJson() => {
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
