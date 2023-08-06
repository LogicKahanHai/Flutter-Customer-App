import 'dart:io';

import 'package:flutter/material.dart';

class HomeAddressSelectComponent extends StatefulWidget {
  const HomeAddressSelectComponent({super.key});

  @override
  State<HomeAddressSelectComponent> createState() =>
      _HomeAddressSelectComponentState();
}

class _HomeAddressSelectComponentState
    extends State<HomeAddressSelectComponent> {
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            color: Colors.white,
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Deliver to: ',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          RotatedBox(
                            quarterTurns: 3,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.arrow_back_ios_new),
                            ),
                          )
                        ],
                      ),
                      const Row(
                        children: [
                          SizedBox(width: 20),
                          Icon(
                            Icons.info_outline,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'No Shipping address selected',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'ADD',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        : Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Deliver to: ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        RotatedBox(
                            quarterTurns: 3,
                            child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_back_ios_new)))
                      ],
                    ),
                    const Row(
                      children: [
                        SizedBox(width: 20),
                        Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'No Shipping address selected',
                          style: TextStyle(color: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'ADD',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                )
              ],
            ),
          );
  }
}
