import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildOrderDetails(
          'Order Date',
          '12/12/2021',
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Order ID',
          '123456789',
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Payment Method',
          'Cash on Delivery',
          context,
        ),
        const SizedBox(height: 20),
        _buildOrderDetails(
          'Delivery Address',
          '123, ABC Street, XYZ City, 123456',
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
