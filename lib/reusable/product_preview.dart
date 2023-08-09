// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';
import 'package:pk_customer_app/screens/product/ui/product_page.dart';

class Product extends StatefulWidget {
  final void Function() onChangedSetState;
  final void Function()? onAddToCart;
  const Product({
    Key? key,
    required this.onChangedSetState,
    this.onAddToCart,
    required this.id,
  }) : super(key: key);

  //[x]: Add a constructor to accept the product details
  //[x]: Add the ADD button functionality
  //[x] Might want to move this widget to a more accessible place for reusability
  final String id;

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> with TickerProviderStateMixin {
  late AnimationController controller;
  bool isATCLoading = false;
  bool isAdded = false;

  late String _dropdownValue;
  late ProductModel _product;
  late List<VariantModel> _variants;

  @override
  void initState() {
    _product = ProductRepo.getProductById(widget.id);
    getVariants();
    if (_product.selectedVariant == '') {
      ProductRepo.updateSelectedVariant(_product.id, _variants[0].id);
      _product = ProductRepo.getProductById(_product.id);
    }
    _dropdownValue = _product.selectedVariant;
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void getVariants() {
    _variants = ProductRepo.variants
        .where((variant) => variant.productId == _product.id)
        .toList();
  }

  void _onChanged(String? value) {
    if (value == null) return;
    setState(() {
      _dropdownValue = value;
      isAdded = false;
    });
    widget.onChangedSetState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            RouteAnimations(
                    nextPage: ProductPage(_product),
                    animationDirection: AnimationDirection.leftToRight)
                .createRoute());
      },
      child: Container(
        padding: Platform.isIOS
            ? const EdgeInsets.all(15)
            : const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        margin: const EdgeInsets.only(right: 10),
        width: 200,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
          border: Border.fromBorderSide(
            BorderSide(
              color: Colors.grey,
              width: 0.5,
            ),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                  image: DecorationImage(
                    image: AssetImage(_product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.green,
                        size: 18,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        _product.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '₹ ${ProductRepo.getVariantById(
                      _product.id,
                      _product.selectedVariant,
                    ).salePrice.round()}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '₹ ${ProductRepo.getVariantById(
                      _product.id,
                      _product.selectedVariant,
                    ).regPrice.round()}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.black38,
                        width: 1,
                      ),
                    ),
                    height: 40,
                    padding: const EdgeInsets.only(left: 5),
                    child: DropdownButton(
                      underline: Container(
                        height: 0,
                        color: Colors.transparent,
                      ),
                      elevation: 1,
                      items: _variants.map(
                        (variant) {
                          return DropdownMenuItem(
                            value: variant.key,
                            child: Text(
                              variant.value,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      value: _dropdownValue,
                      onChanged: (value) {
                        _onChanged(value);
                        setState(() {});
                      },
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (isAdded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item already in cart'),
                          ),
                        );
                        return;
                      }
                      setState(() {
                        isATCLoading = true;
                      });
                      controller.forward();
                      BlocProvider.of<CartBloc>(context).add(
                        CartAddProductEvent(
                          productId: _product.id,
                          variantId: _dropdownValue,
                        ),
                      );
                      await Future.delayed(const Duration(milliseconds: 1000),
                          () {
                        setState(() {
                          isAdded = true;
                          isATCLoading = false;
                        });
                        controller.reset();
                      });
                      if (widget.onAddToCart != null) {
                        widget.onAddToCart!();
                      }
                      await Future.delayed(const Duration(milliseconds: 5000),
                          () {
                        setState(() {
                          isAdded = false;
                        });
                      });
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith(
                          (states) => const Color.fromRGBO(255, 107, 0, 0.42)),
                      backgroundColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                      foregroundColor: MaterialStateProperty.resolveWith(
                          (states) => PKTheme.primaryColor),
                      shape: MaterialStateProperty.resolveWith(
                        (states) => RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: const BorderSide(
                            color: PKTheme.primaryColor,
                            width: 1.0,
                          ),
                        ),
                      ),
                      shadowColor: MaterialStateProperty.resolveWith(
                          (states) => Colors.transparent),
                    ),
                    child: isAdded
                        ? const Row(
                            children: [
                              Icon(
                                Icons.check,
                                size: 16,
                              ),
                              // SizedBox(width: 5),
                              Text(
                                'ADDED',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        : isATCLoading
                            ? SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  color: PKTheme.primaryColor,
                                  value: controller.value,
                                ),
                              )
                            : const Text(
                                'ADD',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
