import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class Buttons extends StatelessWidget {
  const Buttons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          style: PKTheme.normalElevatedButton.copyWith(
              minimumSize: MaterialStateProperty.resolveWith(
                  (states) => const Size(double.infinity, 52))),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Continue Shopping',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // const SizedBox(height: 10),
        // ElevatedButton(
        //   style: PKTheme.hollowButtonWithoutBorder.copyWith(
        //     minimumSize: MaterialStateProperty.resolveWith(
        //       (states) => const Size(double.infinity, 52),
        //     ),
        //   ),
        //   onPressed: () {},
        //   child: const Text(
        //     'Track my order',
        //     style:
        //         TextStyle(fontSize: 21, decoration: TextDecoration.underline),
        //   ),
        // ),
        const SizedBox(height: 20),
      ],
    );
  }
}
