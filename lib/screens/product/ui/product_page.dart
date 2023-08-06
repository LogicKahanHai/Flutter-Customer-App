// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

//DONE: Add Functionality to Bottom Navigation Bar

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';

import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/reusable/bottom_nav_bar.dart';

import '../components/pdt_components.dart';

class ProductPage extends StatefulWidget {
  final ProductModel product;
  const ProductPage(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  late List<VariantModel> variants;
  int quantity = 1;

  @override
  void initState() {
    variants = ProductRepo.variants
        .where((variant) => variant.productId == widget.product.id)
        .toList();
    super.initState();
  }

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.product.name,
            style: const TextStyle(fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Home > Products > ',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: widget.product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // const SizedBox(height: 20),
                ImageCarousel(product: widget.product),
                const SizedBox(height: 20),
                ItemDetails(product: widget.product),
                const SizedBox(height: 20),
                SizeQty(
                  variants: variants,
                  onSizeChanged: (newVariant) {
                    if (newVariant != null) {
                      ProductRepo.updateSelectedVariant(
                          widget.product.id, newVariant);
                    }
                  },
                  onQuantChanged: (newVal) {
                    setState(() {
                      quantity = newVal;
                    });
                  },
                ),
                const SizedBox(height: 20),
                BuyCartButtons(
                  addToCart: () {
                    //[ ]: Add event to add to cart
                    BlocProvider.of<CartBloc>(context).add(
                      CartAddProductEvent(
                          widget.product.id, widget.product.selectedVariant),
                    );
                  },
                ),
                const SizedBox(height: 20),
                const PincodeComponent(),
                const SizedBox(height: 20),
                const InFoGredients(),
                const SizedBox(height: 20),
                const ReviewsComponent(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: bottomNavBar(
        currentIndex: _currentIndex,
        context: context,
        currentPage: 'product',
      ),
    );
  }
}
