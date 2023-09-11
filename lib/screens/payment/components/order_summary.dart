// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';
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
                  ),
                  child: Image.network(
                    ProductRepo.products
                        .firstWhere((element) =>
                            element.productId ==
                            ProductRepo.variants
                                .firstWhere((element) =>
                                    element.productVariantId ==
                                    widget.orderItems[index].productVariantId)
                                .productId)
                        .image,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const SizedBox(
                        width: 75,
                        height: 75,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: PKTheme.primaryColor,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ProductRepo.products
                          .firstWhere(
                            (element) =>
                                element.productId ==
                                widget.orderItems[index].productId,
                          )
                          .name,
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
                              widget.orderItems[index].productVariantId)
                          .variantName,
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
