import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/user_repo.dart';
import 'package:pk_customer_app/screens/address/components/address_search_item.dart';

class SavedAddresses extends StatefulWidget {
  const SavedAddresses({Key? key}) : super(key: key);

  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Saved Addresses'),
        Container(
          width: double.maxFinite,
          color: Colors.white,
          child: UserRepo.addresses == null
              ? const Center(
                  child: Text('No addresses found'),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: UserRepo.addressesLength,
                  itemBuilder: (context, index) {
                    AddressModel address = UserRepo.addresses![index];

                    return AddressSearchItem(address: address);
                  },
                ),
        )
      ],
    );
  }
}
