import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static CartModel cart = CartModel([]);

  static List<CartItemModel> get products => cart.cartProducts;

  static CartItemModel getCartItemById(String id) =>
      products.where((element) => element.id == id).first;



  static void addProduct(ProductModel product, int quant) {
    try {
      int index = cart.cartProducts.indexWhere(
        (element) =>
            element.productId == product.id &&
            element.variantId == product.selectedVariant,
      );
      if (index != -1) {
        cart.cartProducts[index].quantity += quant;
        cart.cartProducts = cart.cartProducts.toSet().toList();
        return;
      }
      cart.cartProducts.add(
        CartItemModel.fromProduct(
          product,
          cart.cartProducts.toSet().toList().length,
          quant,
        ),
      );
      cart.cartProducts = cart.cartProducts.toSet().toList();
      
    } catch (_) {}
  }

  static void removeProduct(CartItemModel product) {
    try {
      if (product.quantity > 1) {
        product.quantity--;
        return;
      } else {
        cart.cartProducts.remove(product);
        cart.cartProducts = cart.cartProducts.toSet().toList();
      }
    } catch (_) {}
  }

  static num get total {
    double tot = cart.cartProducts.fold(
      0,
      (previousValue, element) =>
          previousValue +
          (element.salePrice == 0
              ? element.regPrice * element.quantity
              : element.salePrice * element.quantity),
    );
    return tot != tot.round() ? tot : tot.round();
  }

  static double get taxes => cart.cartProducts.fold(
        0,
        (previousValue, element) =>
            previousValue +
            (element.salePrice == 0
                ? element.regPrice * element.quantity * 0.13
                : element.salePrice * element.quantity * 0.13),
      );

  static double get deliveryCharge => taxes == 0 ? 0 : 20.0;

  static double get grandTotal => total + taxes + deliveryCharge;

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
