// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/product_model.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class CartItemModel {
  final String id;
  final int productId;
  final int variantId;
  final String productName;
  final String variantName;
  final double regPrice;
  final double salePrice;
  final String image;
  int quantity;
  CartItemModel({
    required this.id,
    required this.productId,
    required this.variantId,
    required this.productName,
    required this.variantName,
    required this.regPrice,
    required this.salePrice,
    required this.image,
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
        image = json['image'],
        quantity = json['quantity'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'productId': productId,
        'variantId': variantId,
        'productName': productName,
        'variantName': variantName,
        'regPrice': regPrice,
        'salePrice': salePrice,
        'image': image,
        'quantity': quantity,
      };

  CartItemModel.fromProduct(ProductModel product, int cartItemLength, int quant)
      : id = cartItemLength.toString(),
        productId = product.productId,
        variantId = product.selectedVariant,
        productName = product.name,
        variantName = ProductRepo.getVariantById(
          product.productId,
          product.selectedVariant,
        ).variantValue,
        regPrice = ProductRepo.getVariantById(
          product.productId,
          product.selectedVariant,
        ).regPrice.toDouble(),
        salePrice = ProductRepo.getVariantById(
          product.productId,
          product.selectedVariant,
        ).salePrice.toDouble(),
        image = product.image,
        quantity = quant;

  double get total =>
      regPrice != salePrice ? salePrice * quantity : regPrice * quantity;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItemModel &&
        other.id == id &&
        other.productId == productId &&
        other.variantId == variantId &&
        other.productName == productName &&
        other.variantName == variantName &&
        other.regPrice == regPrice &&
        other.salePrice == salePrice &&
        other.image == image &&
        other.quantity == quantity;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        variantId.hashCode ^
        productName.hashCode ^
        variantName.hashCode ^
        regPrice.hashCode ^
        salePrice.hashCode ^
        image.hashCode ^
        quantity.hashCode;
  }
}
