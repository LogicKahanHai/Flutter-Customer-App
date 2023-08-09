// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';

import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/cart/components/cart_item_ui.dart';

class CartProducts extends StatefulWidget {
  final void Function() updateCart;
  final bool isUpdating;
  const CartProducts({
    Key? key,
    required this.updateCart,
    required this.isUpdating,
  }) : super(key: key);

  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          if (CartRepo.products.isEmpty)
            const Center(
              child: Text('No items in cart'),
            )
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: CartRepo.products.length,
              itemBuilder: (context, index) {
                return CartItemUi(
                  index: index,
                  updateCart: widget.updateCart,
                );
              },
            )
        ],
      ),
    );
  }
}
