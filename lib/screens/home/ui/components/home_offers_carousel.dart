import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';

class HomeOffersCarousel extends StatefulWidget {
  const HomeOffersCarousel({super.key});

  @override
  State<HomeOffersCarousel> createState() => _HomeOffersCarouselState();
}

class _HomeOffersCarouselState extends State<HomeOffersCarousel> {
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Container(
            padding: const EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: GetOffers.offerList.length,
                  itemBuilder: (context, index, realIndex) {
                    return GetOffers.offerList[index];
                  },
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.3,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: GetOffers.offerList.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? PKTheme.primaryColor
                            : PKTheme.primaryColor.withOpacity(0.42),
                      ),
                      duration: const Duration(milliseconds: 500),
                    );
                  }).toList(),
                ),
              ],
            ),
          )
        : Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            color: Colors.white,
            child: Column(
              children: [
                CarouselSlider(
                  items: GetOffers.offerList,
                  options: CarouselOptions(
                    scrollPhysics: const BouncingScrollPhysics(),
                    height: MediaQuery.of(context).size.height * 0.4,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: GetOffers.offerList.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      width: 12.0,
                      height: 12.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == entry.key
                            ? PKTheme.primaryColor
                            : PKTheme.primaryColor.withOpacity(0.42),
                      ),
                      duration: const Duration(milliseconds: 500),
                    );
                  }).toList(),
                ),
              ],
            ),
          );
  }
}

class GetOffers {
  final List<Widget> _itemList = <Widget>[
    Image.asset(
      'assets/images/offers/offer1.png',
      height: 283,
      width: 321,
    ),
    Image.asset(
      'assets/images/offers/offer2.png',
      height: 283,
      width: 321,
    ),
    Image.asset(
      'assets/images/offers/offer1.png',
      height: 283,
      width: 321,
    ),
  ];

  static List<Widget> get offerList => GetOffers()._itemList;
}
