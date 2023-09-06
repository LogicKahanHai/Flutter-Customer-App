// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/repo_constants.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/address/ui/address_map_page.dart';

class Payment extends StatefulWidget {
  final void Function(String) updatePaymentMethod;
  const Payment({
    Key? key,
    required this.updatePaymentMethod,
  }) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  bool isRazorpaySelected = false;
  bool isCodAllowed = false;
  bool isRazorpayAllowed = false;

  Future checkPaymentMethods() async {
    if (UserRepo.addressesLength == 0) {
      isCodAllowed = false;
      isRazorpayAllowed = false;
    } else {
      String addressId = UserRepo.currentAddress!.id;
      final response = await CartRepo.getPaymentMethods(addressId);
      if (response[0]) {
        try {
          for (var paymentMethod in response[1]) {
            if (paymentMethod['name'] == RepoConstants.codPaymentMethodId &&
                paymentMethod['isActive']) {
              isCodAllowed = true;
            } else if (paymentMethod['name'] ==
                    RepoConstants.razorpayPaymentMethodId &&
                paymentMethod['isActive']) {
              isRazorpayAllowed = true;
              isRazorpaySelected = true;
              widget.updatePaymentMethod(
                RepoConstants.razorpayPaymentMethodId,
              );
            }
          }
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
    setState(() {});
  }

  @override
  void initState() {
    checkPaymentMethods();
    super.initState();
    // if (isRazorpayAllowed) {
    //   widget.updatePaymentMethod(RepoConstants.razorpayPaymentMethodId);
    // } else if (isCodAllowed) {
    //   widget.updatePaymentMethod(RepoConstants.codPaymentMethodId);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: Platform.isIOS
              ? const EdgeInsets.symmetric(horizontal: 15.0)
              : const EdgeInsets.symmetric(horizontal: 7.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isRazorpayAllowed)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (isRazorpaySelected) return;
                      setState(() {
                        isRazorpaySelected = true;
                        widget.updatePaymentMethod(
                          RepoConstants.razorpayPaymentMethodId,
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: isRazorpaySelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: PKTheme.primaryColor,
                                width: 2,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/razorpay.png',
                            height: 30,
                            width: 30,
                            color: isRazorpaySelected
                                ? null
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Razorpay',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (isCodAllowed)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isRazorpaySelected) return;
                      setState(() {
                        isRazorpaySelected = false;
                        widget.updatePaymentMethod(
                          RepoConstants.codPaymentMethodId,
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 4.4),
                      decoration: !isRazorpaySelected
                          ? BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: PKTheme.primaryColor,
                                width: 2,
                              ),
                            )
                          : BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                            ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/icons/cod.png',
                            height: 30,
                            width: 30,
                            color: !isRazorpaySelected
                                ? Colors.green
                                : Colors.grey.shade400,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Cash on Delivery',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (!isCodAllowed && !isRazorpayAllowed)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (!isRazorpaySelected) return;
                      setState(() {
                        isRazorpaySelected = false;
                        widget.updatePaymentMethod(
                          RepoConstants.codPaymentMethodId,
                        );
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(left: 4.4),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              UserRepo.addressesLength == 0
                                  ? 'No Address added'
                                  : 'No Payment methods available for this address',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  RouteAnimations(
                                          nextPage: const AddressMapPage(),
                                          animationDirection:
                                              AnimationDirection.BTT)
                                      .createRoute(),
                                ).then((value) => setState(() {}));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.red,
                                    width: 2,
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Click here to update your address',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
