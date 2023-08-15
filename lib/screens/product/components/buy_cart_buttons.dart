// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';

import 'package:pk_customer_app/constants/theme.dart';

class BuyCartButtons extends StatefulWidget {
  final void Function() addToCart;
  const BuyCartButtons({
    Key? key,
    required this.addToCart,
  }) : super(key: key);

  @override
  _BuyCartButtonsState createState() => _BuyCartButtonsState();
}

class _BuyCartButtonsState extends State<BuyCartButtons> {
  bool isATCLoading = false;
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/Checkmark.png', height: 30),
              // const SizedBox(width: 5),
              const Text(
                'This Product is delivered PAN India',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async {
              if (isATCLoading) return;
              if (isAdded) {
                Navigator.pop(context);
                return;
              }

              try {
                setState(() {
                  isATCLoading = true;
                });
                widget.addToCart();
                await Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    isATCLoading = false;
                    isAdded = true;
                  });
                });
                await Future.delayed(const Duration(milliseconds: 500), () {
                  setState(() {
                    isAdded = false;
                  });
                });
              } catch (_) {}
            },
            style: isAdded
                ? ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith(
                        (states) => const Color.fromRGBO(255, 107, 0, 0.42)),
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.transparent),
                    foregroundColor: MaterialStateProperty.resolveWith(
                        (states) => PKTheme.primaryColor),
                    minimumSize: MaterialStateProperty.resolveWith(
                        (states) => const Size(double.infinity, 52.0)),
                    // shape: MaterialStateProperty.resolveWith(
                    //   (states) => RoundedRectangleBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     side: const BorderSide(
                    //       color: PKTheme.primaryColor,
                    //       width: 2.0,
                    //     ),
                    //   ),
                    // ),
                    shadowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.transparent),
                  )
                : ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 52.0),
                  ),
            child: isAdded
                ? const Text(
                    'ADDED TO CART',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : isATCLoading
                    ? const SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 3,
                        ),
                      )
                    : const Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              //[ ]: Add event to navigate to Buy Now
              // context.read<ProductBloc>().add(GoToCartEvent());
            },
            style: PKTheme.hollowButtonWithBorder.copyWith(
              minimumSize: MaterialStateProperty.resolveWith(
                  (states) => const Size(double.infinity, 52.0)),
            ),
            //FIXME: Add event to navigate to Buy Now
            child: const Text(
              'BUY NOW',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: PKTheme.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
