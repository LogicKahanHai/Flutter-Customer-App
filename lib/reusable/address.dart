// ignore_for_file: library_private_types_in_public_api

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/repos/user_repo.dart';
import 'package:pk_customer_app/screens/address/ui/address_search_page.dart';

class AddressContainer extends StatefulWidget {
  final bool shouldRefresh;
  final String? tempAddress;
  final void Function()? refreshHome;
  const AddressContainer(
      {Key? key,
      required this.shouldRefresh,
      this.tempAddress,
      this.refreshHome})
      : super(key: key);

  @override
  _AddressContainerState createState() => _AddressContainerState();
}

class _AddressContainerState extends State<AddressContainer> {
  String? tempAddress;

  @override
  void initState() {
    tempAddress = widget.tempAddress;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: Platform.isIOS
          ? const EdgeInsets.symmetric(horizontal: 20)
          : const EdgeInsets.all(20),
      color: Colors.white,
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
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
                  ],
                ),
                const SizedBox(height: 10),
                tempAddress == null
                    ? UserRepo.addressesLength == 0
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
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: RichText(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: UserRepo
                                            .currentAddress!.addressName
                                            .toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' - ${UserRepo.currentAddress!.line1}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text:
                                            ' - ${UserRepo.currentAddress!.postcode}',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
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
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: RichText(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: widget.tempAddress!.split('-')[0],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' - ${widget.tempAddress!.split('-')[1]}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        ' - ${widget.tempAddress!.split('-')[2]}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
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
                    .then((value) {
                  if (value != null) {
                    setState(() {
                      tempAddress = null;
                    });
                    if (widget.refreshHome != null) widget.refreshHome!();
                  }
                });
              },
              child: Text(
                UserRepo.addressesLength == 0 ? 'ADD' : 'CHANGE',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
