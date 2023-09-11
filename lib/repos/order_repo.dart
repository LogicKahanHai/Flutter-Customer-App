import 'dart:convert';

import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

class OrderRepo {
  static const String _baseUrl = RepoConstants.baseUrl;

  static Future<List<dynamic>> getProfile() async {
    const apiCall = '$_baseUrl/ms/customer/mobile/profile/getProfile';
    final response =
        await RepoConstants.sendRequest(apiCall, null, null, RequestType.get);
    if (jsonDecode(response.body)['data'] == null) {
      return [false];
    }
    return [true];
  }

  static Future<List<dynamic>> createOrder(
      String addressId, String paymentMethod) async {
    List<OrderItemModel> orderItems = [];
    for (var cartItem in CartRepo.products) {
      try {
        orderItems.add(OrderItemModel.fromCartItemModel(cartItem));
      } catch (_) {
        return [false];
      }
    }
    OrderModel createOrder = OrderModel(
      addressId: addressId,
      paymentMethod: paymentMethod,
      discount: 0.0,
      shipping: 0.0,
      totalTax: 0.0,
      total: CartRepo.total.toDouble(),
      orderItems: orderItems,
    );
    const apiCall = '$_baseUrl/ms/customer/mobile/placeOrder/createOrder';

    final body = createOrder.createOrder();
    final response =
        await RepoConstants.sendRequest(apiCall, body, null, RequestType.post);
    if (jsonDecode(response.body)['statusCode'] == 200) {
      final responseOrder = OrderModel.fromJson(
          jsonDecode(response.body)['data'] as Map<String, dynamic>);
      return [true, responseOrder];
    }
    return [false];
  }
}
