// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pk_customer_app/common/blocs/export_blocs.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/repos/repos.dart';

import 'components_address.dart';

class SavedAddresses extends StatefulWidget {
  final void Function() refresh;
  const SavedAddresses({Key? key, required this.refresh}) : super(key: key);

  @override
  _SavedAddressesState createState() => _SavedAddressesState();
}

class _SavedAddressesState extends State<SavedAddresses> {
  final userBloc = UserBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: const Text('Saved Addresses'),
        ),
        const SizedBox(height: 5),
        BlocBuilder(
            bloc: userBloc,
            builder: (context, state) {
              switch (state.runtimeType) {
                case UserLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(
                      color: PKTheme.primaryColor,
                    ),
                  );
                default:
                  return Container(
                    width: double.maxFinite,
                    color: Colors.white,
                    child: UserRepo.addresses!.isEmpty
                        ? Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: const Center(
                              child: Text('No addresses found'),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: UserRepo.addressesLength,
                            itemBuilder: (context, index) {
                              AddressModel address = UserRepo.addresses![index];

                              return AddressSearchItem(
                                address: address,
                                onDelete: () {
                                  userBloc.add(
                                    UserRemoveAddressEvent(id: address.id),
                                  );
                                },
                              );
                            },
                          ),
                  );
              }
            })
      ],
    );
  }
}
