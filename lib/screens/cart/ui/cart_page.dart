// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/reusable/common_components.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/cart/components/cart_components.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double subTotal = 0;
  double deliveryCharge = 0;
  double taxes = 0;
  double grandTotal = 0;
  bool isUpdating = false;
  String paymentMethod = 'gpay';

  void refresh() {
    setState(() {
      subTotal = CartRepo.total.toDouble();
      deliveryCharge = CartRepo.deliveryCharge;
      taxes = CartRepo.taxes;
      grandTotal = CartRepo.grandTotal;
      isUpdating = !isUpdating;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Checkout',
            style: TextStyle(fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          // Navigator.pushAndRemoveUntil(
          //     context,
          //     RouteAnimations(
          //       nextPage: const HomePage(),
          //       animationDirection: AnimationDirection.rightToLeft,
          //     ).createRoute(),
          //     (route) => false),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const AddressContainer(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      CartRepo.products.isEmpty
                          ? 'No items added'
                          : CartRepo.products.length == 1
                              ? '1 item added'
                              : '${CartRepo.products.length} items added',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  CartProducts(
                    updateCart: refresh,
                    isUpdating: isUpdating,
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Bill Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  BillSummary(
                    subTotal: subTotal,
                    deliveryCharge: deliveryCharge,
                    taxes: taxes,
                    grandTotal: grandTotal,
                  ),
                  const SizedBox(height: 20),
                  Payment(updatePaymentMethod: (value) {
                    setState(() {
                      paymentMethod = value;
                    });
                  }),
                  const SizedBox(height: 20),
                  AdditionalProducts(
                    update: refresh,
                  ),
                  CartRepo.products.isNotEmpty
                      ? Container(height: 65, color: Colors.white)
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ),
          CartRepo.products.isNotEmpty
              ? Container(
                  alignment: Alignment.bottomCenter,
                  child: Teaser(
                    onButtonPressed: () {
                      // Navigator.push(
                      //   context,
                      //   RouteAnimations(
                      //     nextPage: const CartPage(),
                      //     animationDirection: AnimationDirection.leftToRight,
                      //   ).createRoute(),
                      // );
                      // .then((value) => initStuff());
                    },
                    value: CartRepo.grandTotal.toStringAsFixed(2),
                    buttonTitle: 'Add Address',
                    buttonStyle: PKTheme.hollowButtonWithBorder,
                    description: Text(
                      'Grand Total',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: bottomNavBar(
        currentIndex: 3,
        currentPage: 'cart',
        context: context,
      ),
    );
  }
}
