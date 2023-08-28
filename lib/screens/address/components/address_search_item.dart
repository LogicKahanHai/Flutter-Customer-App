import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/route_animations.dart';
import 'package:pk_customer_app/models/models.dart';

import '../ui/address_map_page.dart';

class AddressSearchItem extends StatefulWidget {
  final AddressModel address;
  final void Function() onDelete;
  const AddressSearchItem(
      {Key? key, required this.address, required this.onDelete})
      : super(key: key);

  @override
  State<AddressSearchItem> createState() => _AddressSearchItemState();
}

class _AddressSearchItemState extends State<AddressSearchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            widget.address.addressName == 'Home'
                ? Icons.home_outlined
                : widget.address.addressName == 'Work' ||
                        widget.address.addressName == 'Office'
                    ? Icons.work_outlined
                    : Icons.location_on_outlined,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.address.addressName.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  widget.address.line1,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.address.line2 != null &&
                    widget.address.line2!.isNotEmpty)
                  Text(
                    widget.address.line2!,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                const SizedBox(height: 5),
                Text(
                  widget.address.postcode.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            offset: const Offset(-20, 10),
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: const Text('Edit'),
                  onTap: () {
                    Navigator.push(
                      context,
                      RouteAnimations(
                        nextPage:
                            AddressMapPage(toBeUpdatedAddress: widget.address),
                        animationDirection: AnimationDirection.RTL,
                      ).createRoute(),
                    ).then((value) => Navigator.pop(context, true));
                  },
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: const Text('Delete'),
                  onTap: () {
                    widget.onDelete();
                  },
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}
