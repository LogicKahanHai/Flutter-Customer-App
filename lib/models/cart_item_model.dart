// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/product_model.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String variantId;
  final String productName;
  final String variantName;
  final double regPrice;
  final double salePrice;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.regPrice,
    required this.salePrice,
  });

  CartItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'],
        variantId = json['variantId'],
        productName = json['productName'],
        variantName = json['variantName'],
        regPrice = json['regPrice'],
        salePrice = json['salePrice'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'variantId': variantId,
        'productName': productName,
        'variantName': variantName,
        'regPrice': regPrice,
        'salePrice': salePrice,
      };

  CartItemModel.fromProduct(ProductModel product)
      : id = product.id,
        productId = product.id,
        variantId = product.selectedVariant.id,
        productName = product.name,
        variantName = product.selectedVariant.value,
        regPrice = product.selectedVariant.regPrice,
        salePrice = product.selectedVariant.salePrice;
}
