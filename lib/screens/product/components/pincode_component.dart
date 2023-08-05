// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class PincodeComponent extends StatefulWidget {
  const PincodeComponent({Key? key}) : super(key: key);

  @override
  _PincodeComponentState createState() => _PincodeComponentState();
}

class _PincodeComponentState extends State<PincodeComponent> {
  final TextEditingController _pincodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('Check Delivery : '),
              Container(
                width: 160,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: PKTheme.primaryColor.withOpacity(0.12),
                ),
                child: TextField(
                  controller: _pincodeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    hintText: 'Enter Pincode here',
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    contentPadding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 6) {
                      FocusScope.of(context).unfocus();
                    }
                  },
                ),
              ),
              const Spacer(),
              TextButton(
                //[ ]: Add Check Pincode delivery date functionality
                onPressed: () {},
                child: const Text(
                  'CHECK',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset('assets/icons/scooter.png', height: 24),
              const SizedBox(width: 5),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Order now to get delivery by ',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: '15th Aug',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
