// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/models.dart';

class OrderItemModel {
  final String id;
  final int productId;
  final int variantId;
  final int quantity;
  final double price;
  final String name;
  OrderItemModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.quantity,
    required this.price,
    required this.name,
  });

  OrderItemModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'] as String,
        productId = json['productId'] as int,
        variantId = json['variantId'] as int,
        quantity = json['quantity'] as int,
        price = json['price'] as double,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        'itemId': variantId,
        'sku': productId,
        'productId': productId,
        'quantity': quantity,
        'price': price,
        'name': name,
      };

  OrderItemModel.fromCartItem(CartItemModel cartItemModel)
      : id = cartItemModel.id,
        productId = cartItemModel.productId,
        variantId = cartItemModel.variantId,
        quantity = cartItemModel.quantity,
        price = cartItemModel.salePrice,
        name = cartItemModel.productName;
}
