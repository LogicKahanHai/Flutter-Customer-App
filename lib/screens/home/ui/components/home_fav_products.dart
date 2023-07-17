// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class HomeFavProducts extends StatefulWidget {
  const HomeFavProducts({Key? key}) : super(key: key);

  @override
  _HomeFavProductsState createState() => _HomeFavProductsState();
}

class _HomeFavProductsState extends State<HomeFavProducts> {
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List<Product>.generate(
                5,
                (index) => const Product(),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Product extends StatefulWidget {
  //[ ]: Add a constructor to accept the product details
  //[ ]: Add the ADD button functionality
  //-> Might want to move this widget to a more accessible place for reusability

  const Product({Key? key}) : super(key: key);

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  String _dropdownValue = '400 g';

  void _onChanged(String? value) {
    if (value is String) {
      if (value == _dropdownValue) return;
      setState(() {
        _dropdownValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
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
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/products/chakli.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Chakli',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.green,
                      size: 18,
                    ),
                    SizedBox(width: 5),
                    Text(
                      '4.8',
                      style: TextStyle(
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
                const Text(
                  '₹ 100',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '₹ 120',
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
                    items: const [
                      DropdownMenuItem(
                        value: '400 g',
                        child: Text('400 g'),
                      ),
                      DropdownMenuItem(
                        value: '500 g',
                        child: Text('500 g'),
                      ),
                      DropdownMenuItem(
                        value: '600 g',
                        child: Text('600 g'),
                      ),
                    ],
                    value: _dropdownValue,
                    onChanged: _onChanged,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
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
                  child: const Text(
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
}
