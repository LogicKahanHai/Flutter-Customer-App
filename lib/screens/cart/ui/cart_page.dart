// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/cart/bloc/cart_bloc.dart';
import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/reusable/common_components.dart';
import 'package:pk_customer_app/screens/address/ui/address_search_page.dart';
import 'package:pk_customer_app/screens/cart/components/cart_components.dart';
import 'package:pk_customer_app/screens/payment/ui/final_success.dart';
import 'package:pk_customer_app/screens/payment/ui/razorpay_page.dart';

import '../../../constants/route_animations.dart';

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
  bool updatePaymentMethod = false;
  String? paymentMethod;

  late StreamController<Map<String, bool>> paymentMethodsController;

  bool isRazorpayAllowed = false;
  bool isCodAllowed = false;

  Future<void> checkPaymentMethods() async {
    isCodAllowed = false;
    isRazorpayAllowed = false;
    if (kDebugMode) {
      print('checkPayment was called');
    }
    if (UserRepo.addressesLength == 0) {
      isCodAllowed = false;
      isRazorpayAllowed = false;
    } else {
      String addressId = UserRepo.currentAddress!.id;
      if (kDebugMode) {
        print(addressId);
      }
      final response = await CartRepo.getPaymentMethods(addressId);
      if (response[0]) {
        try {
          for (var paymentMethods in response[1]) {
            if (paymentMethods['name'] == RepoConstants.codPaymentMethodId &&
                paymentMethods['isActive']) {
              isCodAllowed = true;
            } else if (paymentMethods['name'] ==
                    RepoConstants.razorpayPaymentMethodId &&
                paymentMethods['isActive']) {
              isRazorpayAllowed = true;
              paymentMethod = RepoConstants.razorpayPaymentMethodId;
            }
          }
          if (kDebugMode) {
            print(
                'isCodAllowed: $isCodAllowed, isRazorpayAllowed: $isRazorpayAllowed');
          }
          paymentMethodsController
              .add({'cod': isCodAllowed, 'razorpay': isRazorpayAllowed});
          return;
        } catch (e) {
          if (kDebugMode) print(e);
          isCodAllowed = false;
          isRazorpayAllowed = false;
        }
      } else {
        isCodAllowed = false;
        isRazorpayAllowed = false;
      }
    }
  }

  void refreshCart() async {
    await checkPaymentMethods();
  }

  initialiseStuff() {
    subTotal = CartRepo.total.toDouble();
    deliveryCharge = CartRepo.deliveryCharge;
    taxes = CartRepo.taxes;
    grandTotal = CartRepo.grandTotal;
  }

  void refresh() {
    if (kDebugMode) {
      print('I was called');
    }
    setState(() {
      subTotal = CartRepo.total.toDouble();
      deliveryCharge = CartRepo.deliveryCharge;
      taxes = CartRepo.taxes;
      grandTotal = CartRepo.grandTotal;
      isUpdating = !isUpdating;
    });
  }

  void onSuccess(response) {
    if (paymentMethod == RepoConstants.razorpayPaymentMethodId) {
      Navigator.pushReplacement(
        context,
        RouteAnimations(
          nextPage: RazorpayPage(
            order: response,
          ),
          animationDirection: AnimationDirection.RTL,
        ).createRoute(),
      );
    } else {
      BlocProvider.of<CartBloc>(context).add(CartClearEvent());
      Navigator.pushReplacement(
        context,
        RouteAnimations(
          nextPage: FinalSuccess(
            order: response,
          ),
          animationDirection: AnimationDirection.RTL,
        ).createRoute(),
      );
    }
  }

  @override
  void initState() {
    paymentMethodsController = StreamController<Map<String, bool>>();
    checkPaymentMethods();
    initialiseStuff();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Checkout',
          style: TextStyle(fontSize: 22, color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
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
                  AddressContainer(
                    refreshHome: refreshCart,
                    shouldRefresh: isUpdating,
                  ),
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
                  StreamBuilder(
                    stream: paymentMethodsController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Payment(
                          isCodAllowed: snapshot.data!['cod']!,
                          isRazorpayAllowed: snapshot.data!['razorpay']!,
                          isRazorpaySelected: paymentMethod != null
                              ? paymentMethod ==
                                  RepoConstants.razorpayPaymentMethodId
                              : snapshot.data!['razorpay']!,
                          updatePaymentMethod: (value) {
                            setState(() {
                              paymentMethod = value;
                            });
                          },
                        );
                      } else {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: PKTheme.primaryColor,
                            strokeWidth: 2,
                          ),
                        );
                      }
                    },
                  ),
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
                    onButtonPressed: () async {
                      if (CartRepo.products.isEmpty) {
                        await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Empty Cart!'),
                              content:
                                  const Text('Please Add items to Cart first!'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'))
                              ],
                            );
                          },
                        );
                        return;
                      }
                      if (UserRepo.addressesLength == 0) {
                        Navigator.push(
                          context,
                          RouteAnimations(
                            nextPage: const AddressSearchPage(),
                            animationDirection: AnimationDirection.RTL,
                          ).createRoute(),
                        ).then((value) => refresh());
                      } else {
                        if (paymentMethod != null) {
                          if (kDebugMode) {
                            print(paymentMethod);
                          }

                          final orderResponse = await OrderRepo.createOrder(
                              UserRepo.currentAddress?.id ??
                                  UserRepo.addresses![0].id,
                              paymentMethod!);

                          if (orderResponse[0]) {
                            onSuccess(orderResponse[1]);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Something went wrong'),
                              ),
                            );
                          }

                          // Navigator.pushReplacement(
                          //   context,
                          //   RouteAnimations(
                          //     nextPage: FinalSuccess(
                          //       order:
                          //     ),
                          //     animationDirection: AnimationDirection.RTL,
                          //   ).createRoute(),
                          // );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please select a payment method'),
                            ),
                          );
                          return;
                        }
                      }
                    },
                    value: CartRepo.grandTotal.toStringAsFixed(2),
                    buttonTitle: UserRepo.addressesLength >= 1
                        ? 'Checkout'
                        : 'Add Address',
                    buttonStyle: UserRepo.addressesLength >= 1
                        ? PKTheme.normalElevatedButton
                        : PKTheme.hollowButtonWithBorder,
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
    );
  }
}
