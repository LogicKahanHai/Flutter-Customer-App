// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pk_customer_app/models/models.dart';

class CartModel {
  static Set<ProductModel> products = {};

  static get cart => products;

  static set setCart(List<ProductModel> cart) {
    products.addAll(cart);
  }

  static void handleAddToCart(ProductModel product) {
    final index = products.toList().indexWhere(
          (element) => element.id == product.id,
        );
    if (index != -1) {
      if (products.toList()[index].selectedVariant.id ==
          product.selectedVariant.id) {
        //TODO: Update the quantity of the product
        return;
      } else {
        //TODO: Add the product to cart
        return;
      }
    }
  }

  double get total =>
      products.fold(0, (sum, item) => sum + item.selectedVariant.salePrice);
}
