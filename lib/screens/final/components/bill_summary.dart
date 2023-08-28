// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class BillSummary extends StatefulWidget {
  final double subTotal;
  final double deliveryCharge;
  final double taxes;
  final double grandTotal;
  final double discount;
  const BillSummary({
    Key? key,
    required this.subTotal,
    required this.deliveryCharge,
    required this.taxes,
    required this.grandTotal,
    required this.discount,
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
                widget.subTotal.round() == widget.subTotal
                    ? '₹ ${widget.subTotal.round()}'
                    : '₹ ${widget.subTotal}',
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
              const Text(
                'Delivery Charges and Taxes',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
              Text(
                widget.taxes != widget.taxes.round()
                    ? '₹ ${widget.taxes + widget.deliveryCharge}'
                    : '₹ ${widget.taxes.round() + widget.deliveryCharge.round()}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          ),
          if (widget.discount != 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Discount',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  widget.discount != widget.discount.round()
                      ? '₹ ${widget.discount}'
                      : '₹ ${widget.discount.round()}',
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
                widget.grandTotal != widget.grandTotal.round()
                    ? '₹ ${widget.grandTotal}'
                    : '₹ ${widget.grandTotal.round()}',
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
