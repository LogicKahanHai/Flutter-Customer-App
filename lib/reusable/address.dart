// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/repos/user_repo.dart';
import 'package:pk_customer_app/screens/address/ui/address_search_page.dart';

class AddressContainer extends StatefulWidget {
  final bool shouldRefresh;
  const AddressContainer({Key? key, required this.shouldRefresh})
      : super(key: key);

  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Container(
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
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                      )
                    ],
                  ),
                  UserRepo.addressesLength == 0
                      ? const Row(
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
                      : Row(
                          children: [
                            const SizedBox(width: 20),
                            Image.asset(
                              'assets/icons/scooter.png',
                              width: 20,
                            ),
                            const SizedBox(width: 10),
                            Text(
                              UserRepo.currentAddress!.addressType.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' - ${UserRepo.currentAddress!.addressLine1}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            )
                          ],
                        ),
                  const SizedBox(height: 15),
                ],
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                          context,
                          RouteAnimations(
                                  nextPage: const AddressSearchPage(),
                                  animationDirection: AnimationDirection.RTL)
                              .createRoute())
                      .then((value) => setState(() {}));
                },
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
      );
    } else {
      return Container(
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
                UserRepo.addressesLength == 0
                    ? const Row(
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
                    : Row(
                        children: [
                          const SizedBox(width: 20),
                          Image.asset(
                            'assets/icons/scooter.png',
                            width: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            UserRepo.currentAddress!.addressType.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            ' - ${UserRepo.currentAddress!.addressLine1}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          )
                        ],
                      ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                        context,
                        RouteAnimations(
                                nextPage: const AddressSearchPage(),
                                animationDirection: AnimationDirection.RTL)
                            .createRoute())
                    .then((value) => setState(() {}));
              },
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
}
