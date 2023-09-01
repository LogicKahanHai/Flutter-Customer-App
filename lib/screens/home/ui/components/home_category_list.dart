import 'package:flutter/material.dart';
import 'package:pk_customer_app/constants/theme.dart';
import 'package:pk_customer_app/repos/product_repo.dart';

class HomeCategoryList extends StatefulWidget {
  const HomeCategoryList({super.key});

  @override
  State<HomeCategoryList> createState() => _HomeCategoryListState();
}

class _HomeCategoryListState extends State<HomeCategoryList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Most Loved Snacks: ',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 140,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: ProductRepo.productCount,
              itemBuilder: (context, index) {
                final category = ProductRepo.categories[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Image.network(
                        category.featuredImg,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const SizedBox(
                            width: 90,
                            height: 90,
                            child: Center(
                              child: CircularProgressIndicator(
                                color: PKTheme.primaryColor,
                                strokeWidth: 2,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class GetCategories {
  final List<Map<String, Widget>> _items = [
    {
      'title': const Text(
        'Laddoos',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/laddoos.png'),
      'subtitle': const Text('Laddoos are amazing!')
    },
    {
      'title': const Text(
        'Healthy',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/healthy.png'),
      'subtitle': const Text('Health is Wealth!')
    },
    {
      'title': const Text(
        'Traditional',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/traditional.png'),
      'subtitle': const Text('Traditions are golden!')
    },
    {
      'title': const Text(
        'Namkeen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/namkeen.png'),
      'subtitle': const Text('Namkeen is the soul of life!')
    },
    {
      'title': const Text(
        'Laddoos',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/laddoos.png'),
      'subtitle': const Text('Laddoos are amazing!')
    },
    {
      'title': const Text(
        'Healthy',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/healthy.png'),
      'subtitle': const Text('Health is Wealth!')
    },
    {
      'title': const Text(
        'Traditional',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/traditional.png'),
      'subtitle': const Text('Traditions are golden!')
    },
    {
      'title': const Text(
        'Namkeen',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      'image': Image.asset('assets/images/categories/namkeen.png'),
      'subtitle': const Text('Namkeen is the soul of life!')
    },
  ];

  //[ ]: Make this container clickable and redirect to the category page
  //[ ]: Format the list above properly according to the API to accept variable values.

  static List<Widget> get categories {
    return GetCategories()._items.map((item) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            item['image']!,
            item['title']!,
          ],
        ),
      );
    }).toList();
  }
}
