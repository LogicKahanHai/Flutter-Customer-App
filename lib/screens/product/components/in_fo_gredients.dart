// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class InFoGredients extends StatefulWidget {
  const InFoGredients({Key? key}) : super(key: key);

  @override
  _InFoGredientsState createState() => _InFoGredientsState();
}

class _InFoGredientsState extends State<InFoGredients> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade600),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Info',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade600),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Key Ingredients',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Icon(
                  Icons.add,
                  size: 18,
                  color: Colors.black,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
