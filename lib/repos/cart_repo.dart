import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static CartModel cart = CartModel([]);

  static List<CartItemModel> get products => cart.cartProducts.toList();

  static void addProduct(ProductModel product) {
    try {
      int index = cart.cartProducts.indexWhere(
        (element) =>
            element.productId == product.id &&
            element.variantId == product.selectedVariant,
      );
      if (index != -1) {
        cart.cartProducts[index].quantity++;
        cart.cartProducts = cart.cartProducts.toSet().toList();
        return;
      }
      cart.cartProducts.add(
        CartItemModel.fromProduct(
          product,
          cart.cartProducts.toSet().toList().length,
        ),
      );
      cart.cartProducts = cart.cartProducts.toSet().toList();
    } catch (_) {}
    
  }

  static void removeProduct(ProductModel product) {
    cart.cartProducts.removeWhere(
      (element) =>
          element.productId == product.id &&
          element.variantId == product.selectedVariant,
    );
  }

  static double get total => cart.cartProducts.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.salePrice == 0
                ? element.regPrice * element.quantity
                : element.salePrice * element.quantity),
      );

  static void clearCart() {
    cart.cartProducts.clear();
  }

  static void setCart(List<CartItemModel> newCart) {
    for (var item in newCart) {
      cart.cartProducts.add(item);
    }
  }

  // static bool increaseQuantity(String cartItemId) {
  //   final index = cart.cartProducts
  //       .toList()
  //       .indexWhere((element) => element.id == cartItemId);
  //   if (index != -1) {
  //     cart.cartProducts.toList()[index].quantity++;
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // static bool decreaseQuantity(String cartItemId) {
  //   final index = cart.cartProducts
  //       .toList()
  //       .indexWhere((element) => element.id == cartItemId);
  //   if (index != -1) {
  //     cart.cartProducts.toList()[index].quantity--;
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
}
