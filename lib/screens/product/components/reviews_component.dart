// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/models/models.dart';
import 'package:pk_customer_app/reusable/rating_stars.dart';

class ReviewsComponent extends StatefulWidget {
  final String productId;
  const ReviewsComponent({
    Key? key,
    this.productId = 'xyz',
  }) : super(key: key);

  @override
  _ReviewsComponentState createState() => _ReviewsComponentState();
}

class _ReviewsComponentState extends State<ReviewsComponent> {
  late final List<ReviewModel> _reviews;

  final List<Color> _colors = [
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.pink,
    Colors.teal,
    Colors.yellow,
  ];

  @override
  void initState() {
    _reviews = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_reviews.isEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Customer Reviews',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const RatingStars(
                          rating: 4.2,
                          color: Colors.green,
                          size: 16,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '4.2',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            color: Colors.grey.shade400,
                            thickness: 2,
                            width: 2,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          '0 ratings',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer()
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 15,
      ),
      width: double.infinity,
      color: Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Customer Reviews',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    children: [
                      const RatingStars(
                        rating: 4.2,
                        color: Colors.green,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '4.2',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.grey.shade400,
                          thickness: 2,
                          width: 2,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        '1,234 ratings',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              TextButton(
                //TODO: Add See All Reviews functionality
                onPressed: () {},
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: PKTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade700, thickness: 1),
          const SizedBox(height: 20),
          MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            itemCount: _reviews.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: _colors[index % _colors.length],
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _reviews[index].name[0],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _reviews[index].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            RatingStars(
                              rating: _reviews[index].rating,
                              color: Colors.green,
                              size: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    if (_reviews[index].title.isNotEmpty)
                      Text(
                        _reviews[index].title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (_reviews[index].image.isNotEmpty)
                      Container(
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image:
                                //[ ]: Add logic for network image
                                AssetImage('assets/images/products/chakli.png'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            bottomLeft: Radius.circular(35),
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    if (_reviews[index].review.isNotEmpty)
                      Text(
                        _reviews[index].review,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.grey.shade700, thickness: 1),
        ],
      ),
    );
  }
}
