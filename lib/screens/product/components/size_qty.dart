// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:pk_customer_app/models/models.dart';

class SizeQty extends StatefulWidget {
  final List<VariantModel> variants;
  final void Function(String?) onSizeChanged;
  final void Function(dynamic) onQuantChanged;
  const SizeQty({
    Key? key,
    required this.variants,
    required this.onSizeChanged,
    required this.onQuantChanged,
  }) : super(key: key);

  @override
  _SizeQtyState createState() => _SizeQtyState();
}

class _SizeQtyState extends State<SizeQty> {
  late String _dropdownValue;
  late List<VariantModel> _variants;
  late int _quant;

  @override
  void initState() {
    _variants = widget.variants;
    _dropdownValue = _variants[0].id;
    _quant = 1;
    super.initState();
  }

  void _onSizeChanged(String? newVar) {
    setState(() {
      _dropdownValue = newVar!;
    });
    widget.onSizeChanged(newVar);
  }

  void _onQuantChanged(dynamic change) {
    switch (change) {
      case 'inc':
        setState(() {
          _quant++;
        });
        widget.onQuantChanged(_quant);
        break;
      case 'dec':
        setState(() {
          _quant--;
        });
        widget.onQuantChanged(_quant);
        break;
      default:
        return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const Text(
                'Size : ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                constraints: const BoxConstraints(maxWidth: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.black38,
                    width: 1,
                  ),
                ),
                height: 40,
                padding: const EdgeInsets.only(left: 5),
                child: DropdownButton(
                  isExpanded: true,
                  elevation: 1,
                  underline: const SizedBox(),
                  items: _variants.map(
                    (variant) {
                      return DropdownMenuItem(
                        value: variant.variantName,
                        child: Container(
                          constraints: const BoxConstraints(maxWidth: 100),
                          child: Text(
                            variant.variantValue,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                  value: _dropdownValue,
                  onChanged: (value) => _onSizeChanged(value),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Qty : ',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Colors.grey.shade400,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quant == 1) {
                          return;
                        } else {
                          _onQuantChanged('dec');
                        }
                      },
                      icon: const Icon(Icons.remove),
                      iconSize: 16,
                      color: _quant == 1 ? Colors.red : Colors.black,
                    ),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: _quant.toString(),
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                          TextSpan(
                            text: _quant == 1 ? ' pack' : ' packs',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _onQuantChanged('inc');
                      },
                      icon: const Icon(Icons.add),
                      iconSize: 16,
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
