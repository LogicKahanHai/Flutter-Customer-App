// ignore_for_file: public_member_api_docs, sort_constructors_first, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class Teaser extends StatefulWidget {
  final void Function() onButtonPressed;
  final Widget description;
  final String value;
  final String buttonTitle;
  final ButtonStyle? buttonStyle;
  const Teaser({
    Key? key,
    required this.onButtonPressed,
    required this.description,
    required this.value,
    required this.buttonTitle,
    this.buttonStyle,
  }) : super(key: key);

  @override
  _TeaserState createState() => _TeaserState();
}

class _TeaserState extends State<Teaser> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 65,
      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        color: PKTheme.bottomNavBarBg,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.description,
              Text(
                '₹ ${widget.value}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: widget.onButtonPressed,
            style: widget.buttonStyle != null
                ? widget.buttonStyle!.copyWith(
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                  )
                : PKTheme.normalElevatedButton.copyWith(
                    elevation: MaterialStateProperty.resolveWith((states) => 0),
                  ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
              child: Text(
                widget.buttonTitle,
                style:
                    const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
