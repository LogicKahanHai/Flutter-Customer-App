// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/product_model.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class CartItemModel {
  final String id;
  final String productId;
  final String variantId;
  final String productName;
  final String variantName;
  final double regPrice;
  final double salePrice;
  int quantity;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.regPrice,
    required this.salePrice,
    required this.quantity,
  });

  CartItemModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        productId = json['productId'],
        variantId = json['variantId'],
        productName = json['productName'],
        variantName = json['variantName'],
        regPrice = json['regPrice'],
        salePrice = json['salePrice'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'variantId': variantId,
        'productName': productName,
        'variantName': variantName,
        'regPrice': regPrice,
        'salePrice': salePrice,
        'quantity': quantity,
      };

  CartItemModel.fromProduct(ProductModel product, int cartItemlength)
      : id = cartItemlength.toString(),
        productId = product.id,
        variantId = product.selectedVariant,
        productName = product.name,
        variantName = ProductRepo.getVariantById(
          product.id,
          product.selectedVariant,
        ).value,
        regPrice = ProductRepo.getVariantById(
          product.id,
          product.selectedVariant,
        ).regPrice,
        salePrice = ProductRepo.getVariantById(
          product.id,
          product.selectedVariant,
        ).salePrice,
        quantity = 1;
}
