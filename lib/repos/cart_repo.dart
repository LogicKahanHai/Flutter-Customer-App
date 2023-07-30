import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static CartModel cart = CartModel();

  static List<CartItemModel> get products => cart.products.toList();

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

  static bool increaseQuantity(String cartItemId) {
    final index = cart.products
        .toList()
        .indexWhere((element) => element.id == cartItemId);
    if (index != -1) {
      cart.products.toList()[index].quantity++;
      return true;
    } else {
      return false;
    }
  }

  static bool decreaseQuantity(String cartItemId) {
    final index = cart.products
        .toList()
        .indexWhere((element) => element.id == cartItemId);
    if (index != -1) {
      cart.products.toList()[index].quantity--;
      return true;
    } else {
      return false;
    }
  }
}
