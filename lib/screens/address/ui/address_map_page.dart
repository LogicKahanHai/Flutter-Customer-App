// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/screens/address/components/components_address.dart';

class AddressMapPage extends StatefulWidget {
  const AddressMapPage({Key? key}) : super(key: key);

  @override
  _AddressMapPageState createState() => _AddressMapPageState();
}

class _AddressMapPageState extends State<AddressMapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Mark Location', style: TextStyle(color: Colors.black)),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
      ),
      body: const MapComponent(),
    );
  }
}
