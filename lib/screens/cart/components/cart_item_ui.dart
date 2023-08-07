// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

import '../../../common/blocs/export_blocs.dart';

class CartItemUi extends StatefulWidget {
  final int index;
  final void Function() updateCart;
  const CartItemUi({
    Key? key,
    required this.index,
    required this.updateCart,
  }) : super(key: key);

  @override
  _CartItemUiState createState() => _CartItemUiState();
}

class _CartItemUiState extends State<CartItemUi> {
  late final CartItemModel cartItem;

  @override
  void initState() {
    cartItem = CartRepo.cart.cartProducts[widget.index];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        // color: Colors.grey.shade100,
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              image: DecorationImage(
                image: AssetImage(cartItem.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cartItem.productName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  cartItem.variantName,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (cartItem.quantity > 1) {
                              BlocProvider.of<CartBloc>(context).add(
                                CartRemoveProductEvent(
                                  cartItem.productId,
                                  cartItem.variantId,
                                ),
                              );
                              widget.updateCart();
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Remove item'),
                                  content: const Text(
                                      'Are you sure you want to remove this item from cart?'),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('No')),
                                    TextButton(
                                        onPressed: () {
                                          BlocProvider.of<CartBloc>(context)
                                              .add(
                                            CartRemoveProductEvent(
                                              cartItem.productId,
                                              cartItem.variantId,
                                            ),
                                          );
                                          Navigator.pop(context);
                                          widget.updateCart();
                                        },
                                        child: const Text('Yes')),
                                  ],
                                ),
                              );
                            }
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.shade200,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.remove,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: cartItem.quantity.toString(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text:
                                    cartItem.quantity > 1 ? ' packs' : ' pack',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<CartBloc>(context).add(
                              CartAddProductEvent(
                                productId: cartItem.productId,
                                variantId: cartItem.variantId,
                                quantity: 1,
                              ),
                            );
                            widget.updateCart();
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color:
                                  Colors.grey.shade200, // PKTheme.primaryColor,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: Colors.grey,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      '₹ ${cartItem.total.round()}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
