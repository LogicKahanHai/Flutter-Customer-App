// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/constants/theme.dart';

import '../../../../common/blocs/export_blocs.dart';
import '../../../../models/models.dart';
import '../../../../repos/repos.dart';

class HomeFavProducts extends StatefulWidget {
  const HomeFavProducts({Key? key}) : super(key: key);

  @override
  _HomeFavProductsState createState() => _HomeFavProductsState();
}

class _HomeFavProductsState extends State<HomeFavProducts> {
  final _cartBloc = CartBloc();

  @override
  void initState() {
    _cartBloc.add(CartInitEvent());
    super.initState();
  }

  void rfcTap(ProductModel product) {}

  void atcTap(ProductModel product) {}

  @override
  Widget build(BuildContext context) {
    //[ ]: Make this container clickable and redirect to the product page

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Loved Snacks: ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 311,
            child: BlocConsumer<CartBloc, CartState>(
              listenWhen: (previous, current) => current is CartError,
              buildWhen: (previous, current) => current is! CartError,
              listener: (context, state) {
                if (state is CartError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Item already in cart')));
                }
              },
              builder: (context, state) {
                if (state is CartLoaded) {
                  return ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: ProductRepo.productCount,
                    itemBuilder: (context, index) {
                      return Product(
                        index: index,
                      );
                    },
                  );
                }
                if (state is CartLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return const Center(
                    child: Text('Something Went wrong.'),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class Product extends StatefulWidget {
  //[ ]: Add a constructor to accept the product details
  //[ ]: Add the ADD button functionality
  //-> Might want to move this widget to a more accessible place for reusability
  final int index;
  const Product({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  late ProductModel _product;
  late String _dropdownValue;
  bool isAdded = false;
  late List<VariantModel> _variants;

  void getVariants() {
    _variants = ProductRepo.variants
        .where((variant) => variant.productId == _product.id)
        .toList();
  }

  @override
  void initState() {
    _product = ProductRepo.products[widget.index];
    getVariants();
    if (_product.selectedVariant == '') {
      ProductRepo.updateSelectedVariant(_product.id, _variants[0].id);
    }
    _dropdownValue = _product.selectedVariant;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    onChanged: _onChanged,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    BlocProvider.of<CartBloc>(context)
                        .add(CartAddProductEvent(_product.id, _dropdownValue));
                    setState(() {
                      isAdded = true;
                    });
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
                      : const Text(
                          'ADD',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onChanged(String? value) {
    setState(() {
      _dropdownValue = value!;
    });
  }
}

//DONE: Use single list for all variants and add product id for separation.