// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

//DONE: Add Functionality to Bottom Navigation Bar

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/reusable/common_components.dart';
import 'package:pk_customer_app/constants/route_animations.dart';

import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/cart/ui/cart_page.dart';

import '../../../common/blocs/export_blocs.dart';
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

  void initStuff() {
    variants = ProductRepo.variants
        .where((variant) => variant.productId == widget.product.id)
        .toList();
    selectedVariant = widget.product.selectedVariant;
    setState(() {});
  }

  void refresh(String newVariant) {
    setState(() {
      selectedVariant = newVariant;
    });
  }

  @override
  void initState() {
    initStuff();
    super.initState();
  }

  final int _currentIndex = 0;
  late String selectedVariant;

  @override
  Widget build(BuildContext context) {
    ProductModel pdt = widget.product;

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(pdt.name,
            style: const TextStyle(fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Stack(
        children: [
          Center(
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
                              text: pdt.name,
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
                    ImageCarousel(product: pdt),
                    const SizedBox(height: 20),
                    ItemDetails(productId: pdt.id, variantId: selectedVariant),
                    const SizedBox(height: 20),
                    SizeQty(
                      variants: variants,
                      onSizeChanged: (newVariant) {
                        if (newVariant != null) {
                          ProductRepo.updateSelectedVariant(pdt.id, newVariant);
                          refresh(newVariant);
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
                            productId: pdt.id,
                            variantId: selectedVariant,
                            quantity: quantity,
                          ),
                        );
                        setState(() {});
                      },
                    ),
                    const SizedBox(height: 20),
                    const PincodeComponent(),
                    const SizedBox(height: 20),
                    const InFoGredients(),
                    const SizedBox(height: 20),
                    const ReviewsComponent(),
                    CartRepo.cart.cartProducts.isNotEmpty
                        ? Container(height: 65, color: Colors.white)
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
          ),
          CartRepo.cart.cartProducts.isNotEmpty
              ? Container(
                  alignment: Alignment.bottomCenter,
                  child: Teaser(
                    onButtonPressed: () {
                      Navigator.push(
                        context,
                        RouteAnimations(
                          nextPage: const CartPage(),
                          animationDirection: AnimationDirection.leftToRight,
                        ).createRoute(),
                      ).then((value) => initStuff());
                    },
                    value: CartRepo.total.toStringAsFixed(2),
                    buttonTitle: 'Checkout',
                    description: Row(
                      children: [
                        Text(
                          'Sub Total',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          '|',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          CartRepo.products.length == 1
                              ? '1 item'
                              : '${CartRepo.products.length} items',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      bottomNavigationBar: bottomNavBar(
        currentIndex: _currentIndex,
        context: context,
        currentPage: 'product',
      ),
    );
  }
}
