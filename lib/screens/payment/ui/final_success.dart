// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

import '../components/components.dart';

class FinalSuccess extends StatelessWidget {
  final OrderModel order;
  const FinalSuccess({
    Key? key,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: const Text(
          'Order Confirmed',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                  context,
                  RouteAnimations(
                          nextPage: const HomePage(),
                          animationDirection: AnimationDirection.LTR)
                      .createRoute());
            }
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/icons/final_check.png', width: 100),
                  const SizedBox(height: 10),
                  const Text(
                    'Congratulations! Your order has been placed',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: const Buttons(),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Order Details',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              width: double.infinity,
              child: OrderDetails(
                orderDate: order.orderDate.toString().split(' ')[0],
                orderId: order.id.toString(),
                paymentMethod: order.paymentMethod.toString(),
                deliveryAddress: order.deliveryAddress.toString(),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Order Summary',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.white,
              child: OrderSummary(orderItems: order.orderItems ?? []),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Bill Summary',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              color: Colors.white,
              child: BillSummary(
                subTotal: order.total ?? 0,
                deliveryCharge: order.shipping ?? 0,
                taxes: order.totalTax ?? 0,
                grandTotal: (order.totalTax ?? 0.0) +
                    (order.total ?? 0) +
                    (order.shipping ?? 0) +
                    (order.shippingTax ?? 0) +
                    (order.discountTax ?? 0) +
                    (order.cartTax ?? 0),
                discount: order.discount ?? 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
