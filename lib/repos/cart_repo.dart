import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/models/models.dart';

class CartRepo {
  static final CartModel _cart = CartModel([]);

  static const String _baseUrl = RepoConstants.baseUrl;

  static List<CartItemModel> get products => _cart.cartProducts;

  static CartItemModel getCartItemById(String id) =>
      products.where((element) => element.id == id).first;

  static void addProduct(ProductModel product, int quant) {
    try {
      int index = _cart.cartProducts.indexWhere(
        (element) =>
            element.productId == product.productId &&
            element.variantId == product.selectedVariant,
      );
      if (index != -1) {
        _cart.cartProducts[index].quantity += quant;
        _cart.cartProducts = _cart.cartProducts.toSet().toList();
        return;
      }
      _cart.cartProducts.add(
        CartItemModel.fromProduct(
          product,
          _cart.cartProducts.toSet().toList().length,
          quant,
        ),
      );
      _cart.cartProducts = _cart.cartProducts.toSet().toList();
    } catch (_) {}
  }

  static void removeProduct(CartItemModel product) {
    try {
      if (product.quantity > 1) {
        product.quantity--;
        return;
      } else {
        _cart.cartProducts.remove(product);
        _cart.cartProducts = _cart.cartProducts.toSet().toList();
      }
    } catch (_) {}
  }

  static num get total {
    double tot = _cart.cartProducts.fold(
      0,
      (previousValue, element) =>
          previousValue +
          (element.salePrice == 0
              ? element.regPrice * element.quantity
              : element.salePrice * element.quantity),
    );
    return tot != tot.round() ? tot : tot.round();
  }

  static double get taxes => _cart.cartProducts.fold(
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
    _cart.cartProducts.clear();
  }

  static void setCart(List<CartItemModel> newCart) {
    for (var item in newCart) {
      _cart.cartProducts.add(item);
    }
  }

  static Future<List<dynamic>> getPaymentMethods(String addressId) async {
    final String apiCall =
        '$_baseUrl/ms/customer/mobile/payments/getAvailablePayment/$addressId';
    final response = await RepoConstants.sendRequest(
      apiCall,
      null,
      null,
      RequestType.get,
    );
    if (jsonDecode(response.body)['statusCode'] == 200) {
      return [true, jsonDecode(response.body)['data']];
    } else {
      return [false];
    }
  }

  static Future<List<dynamic>> checkProfile() async {
    //TODO: Implement this for Checking the profile before creating order
    return [];
  }

  static Future<void> sendPaymentMethodId(String paymentMethodId) async {
    const String apiCall =
        '$_baseUrl/ms/customer/mobile/placeOrder/createOrder';
    final body = {
      "paymentMethodId": paymentMethodId,
    };
    await RepoConstants.sendRequest(
      apiCall,
      body,
      null,
      RequestType.post,
    );
    if (kDebugMode) {
      print('call was made.');
    }
    //TODO: Implement this for Sending the payment method id
  }

  //TODO: Implement this for Cart

  // static Future<bool> updateCart() async {
  //   try {
  //     const String apiCall = '$_baseUrl/ms/customer/mobile/cart/updateCart';
  //
  //     final body = jsonEncode({
  //       'customerId': RepoConstants.customerId,
  //       'cartItems': _cart.cartProducts.map((e) => e.toJson()).toList(),
  //     });
  //
  //     if (jsonDecode(response.body)['statusCode'] == 200) {
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } catch (_) {
  //     return false;
  //   }
  // }

  // static bool increaseQuantity(String cartItemId) {
  //   final index = _cart.cartProducts
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
