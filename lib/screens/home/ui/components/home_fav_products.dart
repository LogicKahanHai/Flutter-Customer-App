// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pk_customer_app/reusable/common_components.dart';

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
    //[x]: Make this container clickable and redirect to the product page

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
                        id: '${index + 1}',
                        onChangedSetState: () {
                          setState(() {});
                        },
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



//DONE: Use single list for all variants and add product id for separation.