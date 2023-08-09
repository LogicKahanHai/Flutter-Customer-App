// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

import 'package:pk_customer_app/models/models.dart';

class CartTeaser extends StatefulWidget {
  final void Function() onCheckoutPressed;
  final CartModel cart;
  const CartTeaser({
    Key? key,
    required this.onCheckoutPressed,
    required this.cart,
  }) : super(key: key);

  @override
  _CartTeaserState createState() => _CartTeaserState();
}

class _CartTeaserState extends State<CartTeaser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: PKTheme.bottomNavBarBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Sub Total',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '|',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    widget.cart.cartProducts.length == 1
                        ? '${widget.cart.cartProducts.length} item'
                        : '${widget.cart.cartProducts.length} items',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
              Text(
                '₹ ${widget.cart.total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: widget.onCheckoutPressed,
            child: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Checkout',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
