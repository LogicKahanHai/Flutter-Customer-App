// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/cart_item_model.dart';
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
  final cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: cartBloc,
      builder: (context, state) {
        if (state is CartLoaded) {
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
                      CartItemModel cartItem = CartRepo.products[index];
                      return CartItemUi(
                        decrement: () async {
                          if (cartItem.quantity > 1) {
                            cartBloc.add(CartRemoveProductEvent(
                                cartItemId: cartItem.id));
                            await Future.delayed(
                                const Duration(milliseconds: 200));
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
                                      onPressed: () async {
                                        cartBloc.add(CartRemoveProductEvent(
                                            cartItemId: cartItem.id));
                                        Navigator.pop(context);
                                        await Future.delayed(
                                            const Duration(milliseconds: 200));
                                        widget.updateCart();
                                      },
                                      child: const Text('Yes')),
                                ],
                              ),
                            );
                          }
                        },
                        increment: () async {
                          cartBloc.add(
                            CartAddProductEvent(
                              productId: cartItem.productId,
                              variantId: cartItem.variantId,
                            ),
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 200));
                          widget.updateCart();
                        },
                        cartItem: cartItem,
                      );
                    },
                  )
              ],
            ),
          );
        } else {
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            color: Colors.white,
            child: const Center(
              child: CircularProgressIndicator(
                color: PKTheme.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
