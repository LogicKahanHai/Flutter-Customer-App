// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:pk_customer_app/models/order_item_model.dart';

class OrderModel {
  final String id;
  final String userId;
  final String addressId;
  final String paymentMethod;
  final DateTime orderDate;
  final double totalAmount;
  final double discount;
  final double shipping;
  final double tax;
  final double subTotal;
  final List<OrderItemModel> orderItems;
  OrderModel({
    required this.id,
    required this.userId,
    required this.addressId,
    required this.paymentMethod,
    required this.orderDate,
    required this.totalAmount,
    required this.discount,
    required this.shipping,
    required this.tax,
    required this.subTotal,
    required this.orderItems,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        userId = json['userId'] as String,
        addressId = json['addressId'] as String,
        paymentMethod = json['paymentMethod'] as String,
        orderDate = DateTime.parse(json['orderDate'] as String),
        totalAmount = json['totalAmount'] as double,
        discount = json['discount'] as double,
        shipping = json['shipping'] as double,
        tax = json['tax'] as double,
        subTotal = json['subTotal'] as double,
        orderItems = (json['orderItems'] as List<dynamic>)
            .map((e) => OrderItemModel.fromJSON(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'addressId': addressId,
        'paymentMethod': paymentMethod,
        'orderDate': orderDate.toIso8601String(),
        'totalAmount': totalAmount,
        'discount': discount,
        'shipping': shipping,
        'tax': tax,
        'subTotal': subTotal,
        'orderItems': orderItems.map((e) => e.toJson()).toList(),
      };
}
