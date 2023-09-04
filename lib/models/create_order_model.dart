// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/order_item_model.dart';

class CreateOrderModel {
  final String addressId;
  final String paymentMethod;
  final double totalAmount;
  final double discount;
  final double shipping;
  final double tax;
  final double subTotal;
  final List<OrderItemModel> orderItems;
  CreateOrderModel({
    required this.addressId,
    required this.paymentMethod,
    required this.totalAmount,
    this.discount = 0.0,
    this.shipping = 0.0,
    this.tax = 0.0,
    required this.subTotal,
    required this.orderItems,
  });

  CreateOrderModel.fromJson(Map<String, dynamic> json)
      : addressId = json['addressId'] as String,
        paymentMethod = json['paymentMethod'] as String,
        totalAmount = json['totalAmount'] as double,
        discount = json['discount'] as double,
        shipping = json['shipping'] as double,
        tax = json['tax'] as double,
        subTotal = json['subTotal'] as double,
        orderItems = (json['orderItems'] as List<dynamic>)
            .map((e) => OrderItemModel.fromJSON(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'addressId': addressId,
        'paymentMethodId': paymentMethod,
        'total': totalAmount,
        'shipping_total': shipping,
        'totalTax': tax,
        'products': orderItems.map((e) => e.toJson()).toList(),
      };
}
