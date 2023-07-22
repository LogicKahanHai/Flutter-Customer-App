import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static CartModel cart = const CartModel(products: <ProductModel>[]);

  static set setCart(CartModel cart) => CartRepo.cart = cart;

  static CartModel? get getCart => CartRepo.cart;

  static bool get isCartEmpty => cart.products.isEmpty;

  static void clearCart() => cart.products.clear();

  static void loadCart(CartModel cart) => setCart = cart;

  static void addToCart(ProductModel product) => cart.products.add(product);

  static void removeFromCart(ProductModel product) =>
      cart.products.remove(product);
}
