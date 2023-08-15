// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

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
  bool isGpaySelected = true;

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
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (isGpaySelected) return;
                    setState(() {
                      isGpaySelected = true;
                      widget.updatePaymentMethod('gpay');
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: isGpaySelected
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
                          'assets/icons/gpay.png',
                          height: 30,
                          width: 30,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Google Pay',
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
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!isGpaySelected) return;
                    setState(() {
                      isGpaySelected = false;
                      widget.updatePaymentMethod('cod');
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: !isGpaySelected
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
            ],
          ),
        ),
      ],
    );
  }
}
