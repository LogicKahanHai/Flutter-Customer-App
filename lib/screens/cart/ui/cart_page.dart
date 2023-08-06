// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/common/components/common_components.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/screens/home/ui/home_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text('Checkout',
            style: TextStyle(fontSize: 22, color: Colors.black)),
        leading: IconButton(
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              RouteAnimations(
                nextPage: const HomePage(),
                animationDirection: AnimationDirection.rightToLeft,
              ).createRoute(),
              (route) => false),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Center(
          child: Container(
        child: const SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              AddressContainer(),
              const SizedBox(height: 20),
            ],
          ),
        ),
      )),
    );
  }
}
