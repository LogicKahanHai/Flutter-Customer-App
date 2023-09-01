// ignore_for_file: library_private_types_in_public_api

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';

class ImageCarousel extends StatefulWidget {
  final ProductModel product;
  const ImageCarousel({Key? key, required this.product}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final CarouselController _carouselController = CarouselController();
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: Column(
        children: [
          if (widget.product.gallery.length == 1)
            Image.network(
              widget.product.gallery[0],
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: PKTheme.primaryColor,
                    strokeWidth: 2,
                  ),
                );
              },
            ),
          if (widget.product.gallery.length > 1)
            CarouselSlider(
              carouselController: _carouselController,
              items: widget.product.gallery.map((image) {
                return Image.network(
                  image,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(
                        color: PKTheme.primaryColor,
                        strokeWidth: 2,
                      ),
                    );
                  },
                );
              }).toList(),
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
          const SizedBox(height: 20),
          if (widget.product.gallery.length > 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_current == 0) return;
                      _carouselController.previousPage();
                      _current = _current - 1;
                    });
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                  color: PKTheme.primaryColor,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: widget.product.gallery.asMap().entries.map((entry) {
                    return AnimatedContainer(
                      width: 80.0,
                      height: 80.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _current == entry.key
                              ? PKTheme.primaryColor
                              : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      duration: const Duration(milliseconds: 200),
                      child: Image.network(
                        entry.value,
                        fit: BoxFit.contain,
                      ),
                    );
                  }).toList(),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      if (_current == widget.product.gallery.length - 1) {
                        return;
                      }
                      _carouselController.nextPage();
                      _current = _current - 1;
                    });
                  },
                  icon: const Icon(Icons.arrow_forward_ios),
                  color: PKTheme.primaryColor,
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class GetImagess {
  static List<Widget> returnList(String imageAsset) {
    return [
      Image.asset(
        imageAsset,
        fit: BoxFit.contain,
      ),
      Image.asset(
        imageAsset,
        fit: BoxFit.contain,
      ),
      Image.asset(
        imageAsset,
        fit: BoxFit.contain,
      ),
    ];
  }
}
