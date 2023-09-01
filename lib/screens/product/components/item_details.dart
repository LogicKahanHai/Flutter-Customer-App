// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/product_repo.dart';
import 'package:pk_customer_app/reusable/rating_stars.dart';

class ItemDetails extends StatefulWidget {
  final int productId;
  final int variantId;
  final int quantity;
  const ItemDetails({
    Key? key,
    required this.productId,
    required this.variantId,
    required this.quantity,
  }) : super(key: key);

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  late VariantModel selectedVariant;
  @override
  void initState() {
    selectedVariant = ProductRepo.getVariantById(
      widget.productId,
      widget.variantId,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    selectedVariant = ProductRepo.getVariantById(
      widget.productId,
      widget.variantId,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ProductRepo.getProductById(widget.productId).name,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const RatingStars(
                rating: 4.2,
                color: Colors.green,
                size: 16,
              ),
              const SizedBox(width: 10),
              const Text(
                '4.2',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                height: 20,
                child: VerticalDivider(
                  color: Colors.grey.shade400,
                  thickness: 2,
                  width: 2,
                ),
              ),
              const SizedBox(width: 10),
              const Text(
                '1,234 ratings',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text(
                '₹ ${selectedVariant.salePrice.round() * widget.quantity}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '₹ ${selectedVariant.regPrice.round() * widget.quantity}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                '${ProductRepo.getDiscount(widget.productId, selectedVariant.productVariantId, widget.quantity)}% OFF',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            'Inclusive of all taxes',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
