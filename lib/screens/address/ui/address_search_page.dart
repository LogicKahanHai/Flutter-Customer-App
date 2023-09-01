// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/screens/address/components/components_address.dart';

class AddressSearchPage extends StatefulWidget {
  const AddressSearchPage({Key? key}) : super(key: key);

  @override
  _AddressSearchPageState createState() => _AddressSearchPageState();
}

class _AddressSearchPageState extends State<AddressSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        title: Text(
          'Add Address',
          style: TextStyle(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context, true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const AddressSearch(),
            const SizedBox(height: 20),
            SavedAddresses(
              refresh: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
