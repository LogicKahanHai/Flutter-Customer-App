// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:pk_customer_app/models/models.dart';

class CartModel {
  List<CartItemModel> cartProducts;
  CartModel(this.cartProducts);
  
  double get total {
    double total = 0;
    for (var element in cartProducts) {
      total += element.total;
    }
    return total;
  }
}
