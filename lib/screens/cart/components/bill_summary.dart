// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/repos.dart';

class BillSummary extends StatefulWidget {
  final double subTotal;
  final double deliveryCharge;
  final double taxes;
  final double grandTotal;
  const BillSummary({
    Key? key,
    required this.subTotal,
    required this.deliveryCharge,
    required this.taxes,
    required this.grandTotal,
  }) : super(key: key);

  @override
  _BillSummaryState createState() => _BillSummaryState();
}

class _BillSummaryState extends State<BillSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Sub Total',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                '₹ ${CartRepo.total.toString()}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Charges',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  if (CartRepo.total < 1000 && CartRepo.total > 500)
                    Text(
                      'order snacks worth ₹${1000 - CartRepo.total} more to get free delivery',
                      style: TextStyle(
                        fontSize: Platform.isIOS ? 14 : 13,
                        fontWeight: FontWeight.w500,
                        color: PKTheme.primaryColor,
                      ),
                    ),
                ],
              ),
              Text(
                CartRepo.taxes != CartRepo.taxes.round()
                    ? '₹ ${CartRepo.taxes + CartRepo.deliveryCharge}'
                    : '₹ ${CartRepo.taxes.round() + CartRepo.deliveryCharge.round()}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(
            thickness: 1,
            color: Colors.grey,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Grand Total',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                CartRepo.grandTotal != CartRepo.grandTotal.round()
                    ? '₹ ${CartRepo.grandTotal}'
                    : '₹ ${CartRepo.grandTotal.round()}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
