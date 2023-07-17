import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class HomeAbout extends StatelessWidget {
  const HomeAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      color: Colors.white,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'Bringing ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: '‘Maa-ke-haath’',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: PKTheme.primaryColor,
                  ),
                ),
                TextSpan(
                  text: ' ka khana to your doorstep!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Our home made snacks are the way to bring you quality binge-time experiences.\nWe’ve stocked a range of yummy goodies that will enliven your taste buds and make you come back for more.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(
                'assets/images/misc/home-about-free-del.png',
                height: 62,
              ),
              Image.asset(
                'assets/images/misc/home-about-prem.png',
                height: 62,
              ),
              Image.asset(
                'assets/images/misc/home-about-hand.png',
                height: 62,
              ),
              Image.asset(
                'assets/images/misc/home-about-cash.png',
                height: 62,
              ),
            ],
          )
        ],
      ),
    );
  }
}
