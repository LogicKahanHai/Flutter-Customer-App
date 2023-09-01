// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/reusable/common_components.dart';

class AdditionalProducts extends StatefulWidget {
  final void Function() update;
  const AdditionalProducts({
    Key? key,
    required this.update,
  }) : super(key: key);

  @override
  _AdditionalProductsState createState() => _AdditionalProductsState();
}

class _AdditionalProductsState extends State<AdditionalProducts> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Customers also bought: ',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 311,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: ProductRepo.productCount,
              itemBuilder: (context, index) {
                final product = ProductRepo.products[index];
                return Product(
                  id: product.productId,
                  onChangedSetState: () {
                    setState(() {});
                  },
                  refresh: widget.update,
                  onAddToCart: widget.update,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
