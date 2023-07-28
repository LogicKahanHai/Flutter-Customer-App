// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pk_customer_app/models/models.dart';

class CartModel {
  Set<CartItemModel> products = {};

  get cart => products;

  set setCart(List<CartItemModel> cart) {
    products.addAll(cart);
  }

  void addProduct(ProductModel product) {
    products.add(CartItemModel.fromProduct(product));
  }

  void removeProduct(ProductModel product) {
    products.removeWhere((item) => item.productId == product.id);
  }

  double get total =>
      products.fold(0, (sum, item) => sum + item.salePrice);
}
