// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/order_item_model.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class OrderSummary extends StatefulWidget {
  final List<OrderItemModel> orderItems;
  const OrderSummary({
    Key? key,
    required this.orderItems,
  }) : super(key: key);

  @override
  _OrderSummaryState createState() => _OrderSummaryState();
}

class _OrderSummaryState extends State<OrderSummary> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.orderItems.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: 75,
                height: 75,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/products/chakli.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.orderItems[index].toString(),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      ProductRepo.variants
                          .firstWhere((element) =>
                              element.productVariantId ==
                                  widget.orderItems[index].variantId &&
                              element.productId ==
                                  widget.orderItems[index].productId)
                          .variantValue,
                      style: const TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.orderItems[index].quantity == 1
                          ? 'Qty: ${widget.orderItems[index].quantity} pack'
                          : 'Qty: ${widget.orderItems[index].quantity} packs',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '₹${widget.orderItems[index].price}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
