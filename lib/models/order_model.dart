import 'package:pk_customer_app/models/order_item_model.dart';

class OrderModel {
  int? id;
  String? number;
  String? status;
  String? addressId;
  String? paymentMethod;
  double? discount;
  double? discountTax;
  double? shipping;
  double? shippingTax;
  double? cartTax;
  double? total;
  double? totalTax;
  int? custId;
  String? paymentMethodTitle;
  DateTime? orderDate;
  String? deliveryAddress;
  String? razorpayOrderId;
  List<OrderItemModel>? orderItems;

  OrderModel({
    this.id,
    this.number,
    this.status,
    this.addressId,
    this.paymentMethod,
    this.discount,
    this.discountTax,
    this.shipping,
    this.shippingTax,
    this.cartTax,
    this.total,
    this.totalTax,
    this.custId,
    this.paymentMethodTitle,
    this.orderItems,
    this.orderDate,
    this.razorpayOrderId,
    this.deliveryAddress,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        number = json['number'] as String?,
        status = json['status'] as String?,
        addressId = json['addressId'] as String?,
        paymentMethod = json['payment_method'] as String?,
        discount = double.tryParse(json['discount_total'] as String? ?? '0.0'),
        discountTax = double.tryParse(json['discount_tax'] as String? ?? '0.0'),
        shipping = double.tryParse(json['shipping_total'] as String? ?? '0.0'),
        shippingTax = double.tryParse(json['shipping_tax'] as String? ?? '0.0'),
        cartTax = double.tryParse(json['cart_tax'] as String? ?? '0.0'),
        total = double.tryParse((json['total'] as int? ?? 0).toString()),
        totalTax = double.tryParse(json['total_tax'] as String? ?? '0.0'),
        custId = json['customer_id'] as int?,
        razorpayOrderId = json['razorpay_order_id'] as String?,
        paymentMethodTitle = json['payment_method_title'] as String?,
        orderDate =
            DateTime.tryParse(json['date_created'] as String? ?? '')!.toLocal(),
        deliveryAddress =
            '${json['billing']['address_1'] as String? ?? ''}\n${json['billing']['address_2'] as String? ?? ''}\n${json['billing']['postcode'] as String? ?? ''}',
        orderItems = (json['line_items'] as List<dynamic>)
            .map((e) => OrderItemModel.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() => {
        'id': id,
        'number': number,
        'status': status,
        'addressId': addressId,
        'paymentMethod': paymentMethod,
        'discount': discount ?? 0,
        'discountTax': discountTax ?? 0,
        'shipping': shipping ?? 0,
        'shippingTax': shippingTax ?? 0,
        'cartTax': cartTax ?? 0,
        'total': total,
        'totalTax': totalTax ?? 0,
        'custId': custId,
        'paymentMethodTitle': paymentMethodTitle,
        'orderItems': orderItems?.map((e) => e.toJson()).toList(),
      };

  Map<String, dynamic> createOrder() => {
        'addressId': addressId,
        'paymentMethodId': paymentMethod,
        'shipping_total': shipping,
        'totalTax': totalTax,
        'total': total,
        'products': orderItems?.map((e) => e.createOrder()).toList(),
      };
}
