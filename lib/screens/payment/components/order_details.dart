import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  final String orderDate;
  final String orderId;
  final String paymentMethod;
  final String deliveryAddress;
  const OrderDetails(
      {Key? key,
      required this.orderDate,
      required this.orderId,
      required this.paymentMethod,
      required this.deliveryAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOrderDetails(
          'Order Date',
          '${orderDate.split('-')[2]}/${orderDate.split('-')[1]}/${orderDate.split('-')[0]}',
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Order ID',
          orderId,
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Payment Method',
          paymentMethod.toLowerCase() == 'cod'
              ? 'Cash on Delivery'
              : 'Online Payment',
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Delivery Address',
          deliveryAddress,
          context,
        ),
      ],
    );
  }
}

Widget _buildOrderDetails(String title, String value, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
      SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Text(
          value,
          softWrap: true,
          textAlign: TextAlign.end,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.grey.shade900,
          ),
        ),
      ),
    ],
  );
}
