import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static CartModel cart = CartModel();

  static void addProduct(ProductModel product) {
    cart.addProduct(product);
  }

  static void removeProduct(ProductModel product) {
    cart.removeProduct(product);
  }

  static double get total => cart.total;

  static void clearCart() {
    cart.products.clear();
  }

  static void setCart(List<CartItemModel> cart) {
    for (var item in cart) {
      cart.add(item);
    }
  }
}
